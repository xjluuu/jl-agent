# Windows EXE Build

## Online build machine

```bat
python -m pip install -r requirements-build.txt
build_xjlagent_exe.bat --no-pause
dist\xjlagent.exe --self-check
```

## Offline company machine

On an online machine:

```bat
prepare_offline_wheels.bat
```

Copy the whole project folder, including `wheels/`, to the company machine.

On the company machine:

```bat
build_xjlagent_exe.bat
```

## Notes

- Build on the same architecture as the target computers.
- For normal company Intel/AMD PCs, build on Windows x64.
- `PyMuPDF` is optional. Without it, PDF parsing will show a warning but the agent can still run.
- The generated EXE reads config from the runtime config path; API settings can be changed without rebuilding.
- No trial, payment, or activation code is required. The EXE enters the normal UI directly.

## Useful checks

Run these after packaging:

```bat
dist\xjlagent.exe --self-check
dist\xjlagent.exe --config-path
dist\xjlagent.exe --print-config
```
