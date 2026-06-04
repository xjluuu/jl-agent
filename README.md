# JL-Agent

[English](README.md) | [简体中文](README.zh-CN.md)

**A one-file local AI agent for restricted enterprise environments, with optional Windows EXE deployment.**

JL-Agent is designed for teams that cannot rely on cloud-first developer tools, Docker, external plugin marketplaces, or every coworker having Python installed. It runs from a single Python file on macOS, Windows, and Linux; for Windows end users, it can also be packaged into a standalone `.exe`. It includes local configuration, audit logs, permission controls, knowledge-base ingestion, project scanning, patch diffs, and verification workflows.

> Built for the awkward but common reality: restricted company computers, internal model gateways, configurable shared storage, limited or no public internet, and non-technical coworkers who still need a usable AI assistant.

## What Makes It Different?

JL-Agent is not just a chat wrapper. It is a local work agent for teams that need controlled execution:

- **Role-based permissions**: admins can use development tools, maintainers can feed shared knowledge, and viewers can use safe analysis/chat workflows.
- **Parallel research**: `parallel_research` can split a topic into multiple model-only research tracks and merge the results for multi-angle analysis.
- **Risk-veto research**: `risk_veto_research` adds an independent Risk Agent. If a red flag is triggered, the result returns `veto: true`.
- **Optional A-share daily research bridge**: `stock_market_report` reads a local `stock_research` daily report; admins can run or install the daily cron with `stock_market_run_daily` and `stock_market_install_cron`.
- **Financial and market research workflows**: useful for organizing stock-market notes, company filings, news, risk factors, spreadsheets, and internal research material.
- **Enterprise-friendly deployment**: one Python file, optional Windows EXE, external config, offline wheel workflow, configurable personal/shared storage.
- **Auditable tool use**: tool calls are logged, common secrets are redacted, file writes produce diffs, and dangerous commands are blocked.
- **Local document intelligence**: `analyze_folder` and `study_files` summarize folders of PDFs, Office files, spreadsheets, logs, code, and notes without dumping everything into context.

## Why JL-Agent?

Most agent frameworks assume a modern developer environment. JL-Agent is optimized for a different situation:

- One main file: `xjlagent.py`
- Cross-platform Python mode for macOS, Windows, and Linux
- Optional Windows EXE packaging for users without Python
- External JSON config, so API keys and model endpoints can change without rebuilding
- Offline-friendly dependency workflow with local `wheels/`
- Local audit log for tool calls
- Dangerous command blocking for destructive operations
- Project scan, worktree status, patch diff, and verification helpers
- Optional dashboard mode
- Local memory and skill files

## Example Workflows

Stock and market research:

```text
Use /stock to read the latest daily A-share multi-agent report.
Admins can use /stock run to generate it manually, or /stock install to restore the workday cron job.

Use risk-veto research to review:
1. Company fundamentals and recent filings
2. News and policy catalysts
3. Valuation and peer comparison
4. Key risks and data gaps
5. Independent Risk Agent veto result
```

Internal knowledge work:

```text
Analyze this folder of PDFs, spreadsheets, and meeting notes.
Find the important documents, summarize the risks, and suggest what should be added to the shared knowledge base.
```

Team deployment:

```text
Admin: full tool access and user management
Maintainer: can add approved knowledge
Viewer: safe chat, search, document analysis, and research workflows
```

## Quick Start

```bash
python -m pip install -r requirements.txt
python xjlagent.py --init-config
python xjlagent.py --self-check
python xjlagent.py
```

Useful maintenance commands:

```bash
python xjlagent.py --version
python xjlagent.py --config-path
python xjlagent.py --print-config
python xjlagent.py --project-scan
python xjlagent.py --worktree-status
python xjlagent.py --verify-suggestions
python xjlagent.py --permission-check
python xjlagent.py --run-verify
python xjlagent.py --audit-log
python xjlagent.py --dashboard
```

Offline maturity check:

```bash
python tests/offline_smoke.py
```

This smoke test does not call a model API. It checks the free/open-source state, role permissions, self-check, release-check, and local verification suggestions.

## Platform Support

Python mode works on:

- macOS
- Windows
- Linux

Windows EXE mode is for environments where coworkers cannot install or run Python directly.

## Windows EXE

On a Windows machine with Python:

```bat
python -m pip install -r requirements-build.txt
build_xjlagent_exe.bat --no-pause
dist\xjlagent.exe --self-check
```

For offline company machines, prepare wheels on a networked machine:

```bat
prepare_offline_wheels.bat
```

Then copy the folder to the company PC and run:

```bat
build_xjlagent_exe.bat
```

Build the EXE on the same CPU architecture as your target machines. If coworkers use normal Intel/AMD Windows PCs, build on Windows x64.

## Configuration

JL-Agent creates a runtime config automatically. Do not commit real config files.

By default, JL-Agent uses a user-local data directory and reports the actual path in `--self-check` and `--config-path`.

Storage is configurable and should match your organization:

- `JL_AGENT_HOME`: one directory for both personal and shared data
- `JL_AGENT_PERSONAL_DIR`: per-user data, config, memory, and schedules
- `JL_AGENT_SHARE_DIR`: shared users, shared skills, and shared knowledge

Environment overrides:

```text
JL_AGENT_HOME
JL_AGENT_PERSONAL_DIR
JL_AGENT_SHARE_DIR
JL_AGENT_API_URL
JL_AGENT_API_KEY
JL_AGENT_MODEL
JL_AGENT_STOCK_RESEARCH_DIR
JL_AGENT_STOCK_RESEARCH_PYTHON
JL_AGENT_STOCK_RESEARCH_CRON
JL_AGENT_STOCK_RESEARCH_JOB
```

Optional stock research bridge:

```json
"stock_research": {
  "dir": "path/to/stock_research",
  "python": "",
  "cron": "30 15 * * 1-5",
  "job_name": "A股投研日报"
}
```

`dir` should contain `agents/orchestrator.py` or `orchestrator.py`. View-only users can read the latest report without Python. Admin machines need Python only when they run the report generator or install the cron job.

See [docs/STOCK_RESEARCH.md](docs/STOCK_RESEARCH.md) for the optional A-share report bridge.

Example Windows deployment:

```bat
set JL_AGENT_PERSONAL_DIR=%LOCALAPPDATA%\JL-Agent
set JL_AGENT_SHARE_DIR=\\fileserver\jl-agent
```

Example macOS/Linux deployment:

```bash
export JL_AGENT_HOME="$HOME/.local/share/jl-agent"
```

See [config.example.json](config.example.json).

JL-Agent is free to run. The normal terminal UI no longer requires a trial, payment, or activation code.

## Website

The project landing page lives in [site/](site/). The included GitHub Pages workflow publishes that folder when changes are pushed to `main`.

## Free And Open Source

JL-Agent is open source and free to use under the MIT license. You can run it, modify it, package it as a Windows EXE, and adapt it to your own internal environment.

Use GitHub Issues for bugs, feature requests, documentation improvements, and reproducible packaging problems. Do not post API keys, company documents, private network details, customer data, or other confidential material in public issues.

Financial workflows are research support only. JL-Agent does not provide investment advice, does not place trades, and does not replace your organization's compliance review.

## Agent Maturity Direction

JL-Agent is being developed as a local-first work agent for restricted enterprise environments, not as a hosted platform clone. The near-term focus is reliability, permission safety, task execution loops, multi-agent research, and Windows EXE handover quality.

See:

- [Agent Maturity Plan](docs/AGENT_MATURITY_PLAN.md)
- [Permission Matrix](docs/PERMISSION_MATRIX.md)
- [Task Execution Loop](docs/TASK_EXECUTION_LOOP.md)
- [Safety Model](docs/SAFETY_MODEL.md)

## Engineering Workflow

JL-Agent includes a local engineering workflow layer:

```bash
python xjlagent.py --project-scan
python xjlagent.py --worktree-status
python xjlagent.py --verify-suggestions
python xjlagent.py --run-verify
python xjlagent.py --git-diff
python xjlagent.py --audit-log
```

Interactive commands:

```text
/project
/changes
/verify
/plan
/runverify
/gitdiff
/audit
```

Recommended code-work flow:

1. Build context with project scan and worktree status.
2. Create a visible plan with `/plan loop <title>` or `task_plan(action="loop")`.
3. Execute the smallest scoped step.
4. Run the minimum verification pipeline.
5. Summarize changed files, verification results, and residual risk.

## Safety Layer

JL-Agent is not a full OS sandbox, but it includes local guardrails:

- Enforces role-based tool permissions across TUI and dashboard modes
- Validates the role matrix with `python xjlagent.py --permission-check`
- Blocks obvious destructive commands unless explicitly overridden by an administrator
- Writes tool audit events to `tool_audit.jsonl`
- Redacts common secret patterns in logs
- Returns unified diffs for file writes and patches
- Keeps backups for edited files

Blocked commands can be overridden with:

```text
ALLOW_DANGEROUS: <command>
```

or:

```text
JL_AGENT_ALLOW_DANGEROUS=1
```

Use overrides only for administrator-controlled maintenance.

## What This Is Not

JL-Agent does not try to replace hosted platforms completely. A single offline EXE cannot fully reproduce:

- Managed OS-level sandboxing
- Cloud-hosted parallel agents
- GitHub/Figma/Slack OAuth connectors
- Browser and computer vision control
- A public plugin marketplace
- Real-time market data terminals or automated trading systems

Instead, JL-Agent focuses on the part that is useful in restricted enterprise environments: local execution, configurable storage, EXE packaging when needed, auditability, and practical deployment.

Financial and market research features are for organizing and analyzing information, not financial advice or trading automation. The Risk Agent veto is a research control, not an investment recommendation.

## Roadmap

See [ROADMAP.md](ROADMAP.md).

## Contributing

Contributions are welcome. Start with [CONTRIBUTING.md](CONTRIBUTING.md) and keep changes small, testable, and friendly to the single-file deployment model.

## Security

See [SECURITY.md](SECURITY.md). Never commit real API keys, runtime databases, local knowledge files, logs, or company documents.

## License

MIT. See [LICENSE](LICENSE).
