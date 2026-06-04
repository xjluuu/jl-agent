# Onboarding And Handoff

JL-Agent is meant to be handed to coworkers who may not read source code, may not have Python, and may be using a locked-down Windows computer. The first-run and handoff commands make that state visible.

## Python first run

Run these from the project folder:

```bash
python xjlagent.py --init-config
python xjlagent.py --self-check
python xjlagent.py --permission-check
python xjlagent.py --onboarding
```

`--onboarding` summarizes:

- runtime config path
- personal and shared data paths
- current role
- API configuration status
- self-check warnings or failures
- permission-check status
- suggested next actions

Warnings are acceptable when they describe optional capabilities. Failures should be fixed before handing the tool to another user.

## Windows EXE handoff

After packaging, run:

```bat
dist\xjlagent.exe --self-check
dist\xjlagent.exe --permission-check
dist\xjlagent.exe --exe-check
dist\xjlagent.exe --onboarding
```

`--exe-check` is stricter about packaged delivery. It confirms the executable can start, that role checks pass, and that the runtime paths are visible. On non-Windows systems it reports a warning instead of failing, so the command can still be used in cross-platform verification.

## What to give end users

For a Windows end user without Python, the practical handoff is:

- `dist\xjlagent.exe`
- a short internal note with the model gateway/API configuration policy
- the shared storage path, if your organization uses one
- role assignment guidance from [PERMISSION_MATRIX.md](PERMISSION_MATRIX.md)

Do not distribute real API keys in the public repository. Use environment variables, endpoint policy, or a private config file managed by your organization.

## Useful commands for support

```bat
dist\xjlagent.exe --version
dist\xjlagent.exe --config-path
dist\xjlagent.exe --print-config
dist\xjlagent.exe --self-check
dist\xjlagent.exe --onboarding
```

If a coworker reports that the EXE does not work, ask for the output of `--onboarding` and `--self-check`, with secrets removed.

