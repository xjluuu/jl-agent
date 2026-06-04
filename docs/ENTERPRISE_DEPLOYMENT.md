# Enterprise Deployment

JL-Agent targets restricted enterprise environments where:

- Some users may not have Python.
- Public internet may be unavailable.
- Company data must stay inside internal networks.
- Shared storage may be a Windows drive, network share, NAS path, or local folder.
- Auditability matters.

## Storage model

JL-Agent does not require a specific drive letter or shared folder name. Storage is configured through environment variables:

- `JL_AGENT_HOME`: one directory for all runtime data
- `JL_AGENT_PERSONAL_DIR`: per-user config, memory, and schedules
- `JL_AGENT_SHARE_DIR`: shared users, shared skills, and shared knowledge

If no storage variables are set, JL-Agent uses a user-local data directory and reports it in:

```bat
dist\xjlagent.exe --self-check
dist\xjlagent.exe --config-path
```

Example Windows deployment:

```bat
set JL_AGENT_PERSONAL_DIR=%LOCALAPPDATA%\JL-Agent
set JL_AGENT_SHARE_DIR=\\fileserver\jl-agent
```

Example macOS/Linux deployment:

```bash
export JL_AGENT_HOME="$HOME/.local/share/jl-agent"
```

## Recommended rollout

1. Choose the runtime storage paths for your organization.
2. Configure model gateway settings in environment variables or the generated JSON config.
3. Run `python xjlagent.py --self-check` or `dist\xjlagent.exe --self-check`.
4. Run `python xjlagent.py --permission-check` to confirm role boundaries.
5. Run `python xjlagent.py --onboarding` or `dist\xjlagent.exe --onboarding` and save the output for pilot support.
6. In Python mode, run `python tests/offline_smoke.py` before packaging or rollout.
7. For Windows EXE rollout, run `dist\xjlagent.exe --exe-check` after packaging.
8. Review [PERMISSION_MATRIX.md](PERMISSION_MATRIX.md) and decide who should be Admin, Maintainer, and Viewer.
9. Test internal model gateway connectivity.
10. For Windows end users without Python, build and distribute the EXE.
11. Review `tool_audit.jsonl` during pilot use.

## Environment variables

```bat
set JL_AGENT_PERSONAL_DIR=%LOCALAPPDATA%\JL-Agent
set JL_AGENT_SHARE_DIR=\\fileserver\jl-agent
set JL_AGENT_API_URL=http://internal-model/v1/chat/completions
set JL_AGENT_MODEL=your-model
set JL_AGENT_API_KEY=
```

Use environment variables for scripted deployment, or edit the JSON config file for manual deployment.

## Handoff checklist

Before giving JL-Agent to a normal coworker:

- confirm the user has the intended role
- run `--onboarding` on the target machine
- confirm the API endpoint and model name are correct
- confirm shared storage is reachable, if your deployment uses it
- keep Admin-only tools limited to trusted operators

See [ONBOARDING_AND_HANDOFF.md](ONBOARDING_AND_HANDOFF.md).
