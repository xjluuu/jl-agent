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
4. Test internal model gateway connectivity.
5. For Windows end users without Python, build and distribute the EXE.
6. Review `tool_audit.jsonl` during pilot use.

## Environment variables

```bat
set JL_AGENT_PERSONAL_DIR=%LOCALAPPDATA%\JL-Agent
set JL_AGENT_SHARE_DIR=\\fileserver\jl-agent
set JL_AGENT_API_URL=http://internal-model/v1/chat/completions
set JL_AGENT_MODEL=your-model
set JL_AGENT_API_KEY=
```

Use environment variables for scripted deployment, or edit the JSON config file for manual deployment.
