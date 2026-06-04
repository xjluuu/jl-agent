# Quickstart

JL-Agent can run directly with Python on macOS, Windows, and Linux. On Windows, it can also be packaged as an `.exe` for users who do not have Python.

## 1. Install dependencies

```bash
python -m pip install -r requirements.txt
```

## 2. Initialize config

```bash
python xjlagent.py --init-config
python xjlagent.py --config-path
```

Edit the generated config file and set:

- `api.url`
- `api.key`
- `api.model`

If your internal model gateway does not require authentication, `api.key` can stay empty.

## 3. Run self-check

```bash
python xjlagent.py --self-check
python xjlagent.py --permission-check
python xjlagent.py --onboarding
```

Warnings are acceptable when they describe optional capabilities, such as missing PDF support.

The self-check output shows the actual runtime config and data paths for the current machine.
The onboarding output summarizes first-run readiness, current role, config status, and suggested next actions.

## 4. Run offline smoke test

```bash
python tests/offline_smoke.py
```

This does not call a model API. It checks startup, free/open-source status, role permissions, first-run output, task reporting, research templates, release-check, and verification suggestions.

## 5. Start interactive mode

```bash
python xjlagent.py
```

## 6. Start dashboard

```bash
python xjlagent.py --dashboard
```

Open:

```text
http://127.0.0.1:18888
```

## Free use

JL-Agent is free and open source under the MIT license. No trial, payment, or activation code is required.

## Task loop

For substantial engineering, packaging, or operations tasks, initialize the standard loop:

```text
/plan loop <title>
```

See [TASK_EXECUTION_LOOP.md](TASK_EXECUTION_LOOP.md).

After a substantial task, admins can generate a local handoff report:

```bash
python xjlagent.py --task-report .
```

## Research templates

List built-in templates:

```bash
python xjlagent.py --research-templates
python xjlagent.py --research-template decision
python xjlagent.py --research-template stock
```

See [RESEARCH_WORKFLOWS.md](RESEARCH_WORKFLOWS.md).
