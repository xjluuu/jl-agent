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
- To show your WeChat payment QR in Dashboard, create `dist\payment\wechat_qr.png` next to `dist\xjlagent.exe`, or set `JL_AGENT_WECHAT_QR` to another local image path before launching the EXE.
- On first normal launch, the EXE shows the plan menu. Trial enters directly; paid plans show the payment page and require a manual activation code after payment.

## Manual activation

Client side:

```bat
dist\xjlagent.exe --machine-code
dist\xjlagent.exe --activate ACTIVATION_CODE
dist\xjlagent.exe --license-status
```

Seller side after payment:

```bat
python xjlagent.py --make-activation express MACHINE_CODE
python xjlagent.py --make-activation lifetime MACHINE_CODE
```
