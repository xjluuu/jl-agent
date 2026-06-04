# Permission Matrix

JL-Agent uses local role boundaries to reduce accidental misuse on shared machines.

## Roles

| Role | Intended user | Allowed direction |
| --- | --- | --- |
| `admin` | Owner, IT/admin user, developer operator | Full local tool access, code/project work, user management, cron/process/model controls, shared knowledge maintenance |
| `maintainer` | Trusted business maintainer | Safe assistant workflows and approved knowledge ingestion |
| `viewer` | Normal coworker | Safe chat, local reading/searching, document analysis, and model-only research |

## High-impact tool groups

| Tool group | Examples | Admin | Maintainer | Viewer |
| --- | --- | --- | --- | --- |
| Command/code execution | `execute_command`, `python_execute`, `execute_code` | Yes | No | No |
| File mutation | `write_file`, `patch_file`, `exact_patch` | Yes | No | No |
| Engineering workflow | `project_scan`, `worktree_status`, `task_plan`, `git_diff`, `run_verification` | Yes | No | No |
| Skill maintenance | `learn_skill`, `patch_skill`, `delete_skill`, `load_all_skills` | Yes | No | No |
| Shared knowledge ingestion | `learn` | Yes | Yes | No |
| Cron/process/model controls | `cron_start`, `process_kill`, `set_model`, `list_models` | Yes | No | No |
| Admin visibility | `search_all_sessions`, `audit_log` | Yes | No | No |
| Model-only research | `parallel_research`, `risk_veto_research` | Yes | Yes | Yes |
| Stock report reading | `stock_market_report` | Yes | Yes | Yes |
| Stock report generation/cron | `stock_market_run_daily`, `stock_market_install_cron` | Yes | No | No |

## Enforcement points

- Tool lists are filtered per user before model calls.
- Tool execution checks the same permission rules again before running the tool.
- Development-looking user requests are refused for non-admin users before tool execution.
- Dangerous local commands are blocked even for admins unless explicitly overridden.
- Tool calls are written to the local audit log with common secrets redacted.

## Boundary notes

This is not a sandbox. It is a local policy layer inside the application. For stronger protection, combine JL-Agent with Windows account controls, endpoint policy, a VM/container, or a managed execution environment.

