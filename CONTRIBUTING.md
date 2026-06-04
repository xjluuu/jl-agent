# Contributing

Thanks for considering a contribution to JL-Agent.

## Project Principles

- Keep the single-file runtime usable.
- Prefer small, reviewable changes.
- Do not add mandatory cloud services.
- Do not commit API keys, business files, runtime databases, logs, or packaged build output.
- Preserve Windows enterprise deployment support.
- Preserve the task execution loop: context, plan, execute, verify, risk summary.

## Local Setup

```bash
python -m pip install -r requirements.txt
python xjlagent.py --self-check
python xjlagent.py --permission-check
python xjlagent.py --onboarding
python xjlagent.py --exe-check
python xjlagent.py --release-check
python tests/offline_smoke.py
```

Optional build dependencies:

```bash
python -m pip install -r requirements-build.txt
```

Optional PDF support:

```bash
python -m pip install -r requirements-pdf.txt
```

## Before Opening a Pull Request

Run:

```bash
python -m py_compile xjlagent.py
python xjlagent.py --self-check
python xjlagent.py --permission-check
python xjlagent.py --onboarding
python xjlagent.py --exe-check
python xjlagent.py --release-check
python tests/offline_smoke.py
```

If your change touches packaging, also test on Windows:

```bat
build_xjlagent_exe.bat --no-pause
dist\xjlagent.exe --self-check
dist\xjlagent.exe --permission-check
dist\xjlagent.exe --exe-check
dist\xjlagent.exe --onboarding
```

## Pull Request Guidelines

Include:

- What changed
- Why it changed
- How you tested it
- Any remaining risk

Avoid unrelated refactors in feature PRs.

## Security

If you find a security issue, do not open a public issue with exploit details. See [SECURITY.md](SECURITY.md).
