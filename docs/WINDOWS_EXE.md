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
- To embed your WeChat payment QR into the private EXE, create `payment\wechat_qr.png` before running `build_xjlagent_exe.bat`. Keep this file out of public GitHub; the `payment\` folder is ignored by Git.
- If you do not embed it, the Dashboard can still read `dist\payment\wechat_qr.png` next to `dist\xjlagent.exe`, or `JL_AGENT_WECHAT_QR` can point to another local image path.
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
