# Agent Maturity Plan

JL-Agent should be developed as a local-first work agent for restricted enterprise environments, not as a hosted agent platform clone.

## Product position

JL-Agent is for environments where these assumptions are realistic:

- Coworkers may not have Python.
- Public internet, Docker, cloud plugins, or hosted sandboxes may be unavailable.
- Model access may go through an internal gateway.
- Local files, Office documents, spreadsheets, research notes, and code folders matter.
- Teams need configurable storage paths, role boundaries, and local audit logs.

This makes JL-Agent different from cloud-first developer agents. The goal is not to beat hosted platforms at sandboxing, OAuth, collaboration, or marketplace integrations. The goal is to run usefully where those platforms are hard to deploy.

## Not-a-toy standard

JL-Agent should only claim maturity when the following are true:

- Core startup, config, permission, self-check, and release-check behavior can be tested without a model API.
- Viewer, Maintainer, and Admin boundaries are documented and covered by tests.
- File writes, command execution, cron, process control, and development tools stay behind Admin-only gates.
- Multi-step work follows a visible loop: plan, execute, verify, summarize residual risk.
- Parallel research and Risk Agent veto workflows stay model-only and do not execute local commands.
- Windows EXE users can run self-check and understand missing config without reading source code.
- Public docs do not assume a fixed drive letter, private company path, payment flow, or personal environment.

## Development priorities

1. Reliability baseline

Add low-dependency smoke tests that run without internet or API keys. Keep `python xjlagent.py --release-check` clean before every public push.

2. Permission hardening

Keep all high-impact local actions Admin-only. Document the tool groups, test the role matrix, and make refusal messages explicit enough for non-technical users.

3. Task execution loop

For engineering and operations tasks, guide the agent to maintain a task plan, execute bounded steps, run verification when available, and report what was verified.

4. Research differentiation

Make multi-agent research, Risk Agent veto, and local stock research report reading the visible differentiators. Financial workflows must stay research support only.

5. Packaging and handover

Improve Windows EXE docs, offline wheel workflows, config examples, and first-run diagnostics for coworkers without Python.

6. Gradual modularization

Keep the one-file runtime as the distribution format, but move tests, docs, and generated release assets outside the main file. Only split runtime modules when the EXE packaging workflow remains simple.

## Current stage

JL-Agent is an early productized local agent, not a mature platform. It already has real utility in restricted local environments, but it should be judged by reliability, permission safety, and packaging clarity before feature count.

