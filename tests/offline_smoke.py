#!/usr/bin/env python3
"""Offline smoke tests for JL-Agent.

These checks intentionally avoid model API calls, internet access, and pytest.
They are meant to run on restricted machines before packaging or publishing.
"""

from __future__ import annotations

import os
import sys
import tempfile
from pathlib import Path


def _import_agent(repo_root: Path):
    temp_root = tempfile.TemporaryDirectory(prefix="jl-agent-smoke-")
    os.environ["JL_AGENT_HOME"] = temp_root.name
    os.environ.setdefault("JL_AGENT_API_KEY", "")
    os.environ.setdefault("JL_AGENT_MODEL", "deepseek-v4-pro")
    if str(repo_root) not in sys.path:
        sys.path.insert(0, str(repo_root))
    import xjlagent  # noqa: WPS433 - smoke test imports the local runtime

    return xjlagent, temp_root


def main() -> int:
    repo_root = Path(__file__).resolve().parents[1]
    agent, temp_root = _import_agent(repo_root)
    checks: list[tuple[str, bool, str]] = []

    def check(name: str, ok: bool, detail: str = "") -> None:
        checks.append((name, bool(ok), detail))

    try:
        status = agent.license_status()
        check("free license is active", status.get("active") is True and status.get("plan") == "free", str(status))

        activation_message = agent.make_activation_code(None, None)
        check("activation generator is disabled", "no longer required" in activation_message, activation_message)
        ok, payload, reason = agent.verify_activation_code("anything")
        check("legacy activation verifier is harmless", ok and payload.get("plan") == "free", reason)

        users = {
            "admins": ["admin@host"],
            "learn_whitelist": ["maintainer@host"],
            "users": {
                "admin@host": {},
                "maintainer@host": {},
                "viewer@host": {},
            },
        }
        admin_tools = agent.get_allowed_tool_names("admin@host", users)
        maintainer_tools = agent.get_allowed_tool_names("maintainer@host", users)
        viewer_tools = agent.get_allowed_tool_names("viewer@host", users)

        admin_required = {"execute_command", "write_file", "run_verification", "stock_market_run_daily", "cron_create", "schedule_task", "export_knowledge"}
        dev_blocked = {
            "execute_command",
            "write_file",
            "patch_file",
            "run_verification",
            "stock_market_run_daily",
            "cron_create",
            "cron_remove",
            "schedule_task",
            "cancel_scheduled",
            "export_knowledge",
        }
        research_allowed = {"parallel_research", "risk_veto_research", "stock_market_report"}

        check("admin keeps development tools", admin_required.issubset(admin_tools), str(sorted(admin_required - admin_tools)))
        check("maintainer cannot use dev tools", dev_blocked.isdisjoint(maintainer_tools), str(sorted(dev_blocked & maintainer_tools)))
        check("viewer cannot use dev tools", dev_blocked.isdisjoint(viewer_tools), str(sorted(dev_blocked & viewer_tools)))
        check("maintainer can ingest knowledge", "learn" in maintainer_tools, "")
        check("viewer cannot ingest knowledge", "learn" not in viewer_tools, "")
        check("model-only research is broadly available", research_allowed.issubset(viewer_tools), str(sorted(research_allowed - viewer_tools)))

        permission_checks, permission_code = agent.collect_permission_check()
        check("permission matrix check passes", permission_code == 0, str(permission_checks))

        onboarding = agent.format_onboarding_status(agent.collect_onboarding_status())
        check("onboarding status is available", "JL-Agent" in onboarding and "当前角色" in onboarding, onboarding)

        exe_checks, exe_code = agent.collect_exe_readiness()
        check("exe readiness has no failures", exe_code == 0, str(exe_checks))

        agent.save_users(users)
        memory = agent.Memory()
        try:
            tools = agent.Tools(memory)
            tools.user_id = "viewer@host"
            denied = tools.execute("execute_command", {"command": "echo should_not_run"})
            check("tool executor denies viewer command execution", isinstance(denied, dict) and "error" in denied, str(denied))
            tools.user_id = "maintainer@host"
            denied_export = tools.execute("export_knowledge", {})
            check("tool executor denies maintainer knowledge export", isinstance(denied_export, dict) and "error" in denied_export, str(denied_export))
        finally:
            memory.close()

        check("development classifier catches code work", agent.looks_like_development_request("帮我写一个 Python 脚本修 bug"), "")
        check("development classifier allows research", not agent.looks_like_development_request("总结这些会议纪要里的风险"), "")

        loop_policy = agent.task_execution_loop_policy()
        for phrase in ("Context", "Plan", "Execute", "Verify", "Risk summary"):
            check(f"task loop policy includes {phrase}", phrase in loop_policy, loop_policy)
        loop_plan = agent.default_task_loop_plan("Smoke task loop")
        check("task loop has five standard steps", len(loop_plan.get("items", [])) == 5, str(loop_plan))
        saved_loop = agent.update_engineering_plan("loop", "Smoke task loop")
        statuses = [item.get("status") for item in saved_loop.get("items", [])]
        check("task_plan loop starts first step", statuses[:1] == ["in_progress"], str(statuses))

        task_report = agent.write_task_report(str(repo_root))
        check("task report is persisted", Path(task_report.get("path", "")).exists() and "JL-Agent Task Report" in task_report.get("text", ""), str(task_report))

        template_names = agent.research_template_names()
        check("research templates are available", {"stock", "company_due_diligence", "internal_project"}.issubset(set(template_names)), str(template_names))
        stock_template = agent.format_research_templates("stock")
        check("stock research template includes risk rules", "Risk Rules" in stock_template and "investment advice" in stock_template, stock_template)

        release_checks, release_code = agent.collect_release_check()
        check("release check has no failures", release_code == 0, str(release_checks))

        self_checks, self_code = agent.collect_self_check(check_api=False)
        check("self check has no failures", self_code == 0, str(self_checks))

        scan = agent.collect_project_scan(str(repo_root), max_files=2500)
        verify_commands = scan.get("verify_commands") or []
        check("offline smoke appears in verify suggestions", any("tests/offline_smoke.py" in c for c in verify_commands), str(verify_commands))
        check("permission check appears in verify suggestions", any("--permission-check" in c for c in verify_commands), str(verify_commands))
        check("exe check appears in verify suggestions", any("--exe-check" in c for c in verify_commands), str(verify_commands))
    finally:
        temp_root.cleanup()

    failed = [(name, detail) for name, ok, detail in checks if not ok]
    for name, ok, detail in checks:
        mark = "[OK]" if ok else "[X]"
        suffix = f" - {detail}" if detail and not ok else ""
        print(f"{mark} {name}{suffix}")

    if failed:
        print(f"\nFAILED: {len(failed)} check(s)")
        return 1
    print("\nOffline smoke passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
