# Safety Model

JL-Agent provides local guardrails, not a full sandbox.

## Included guardrails

- Dangerous command blocking
- Tool audit log
- Common secret redaction in logs
- Patch/file-write diffs
- Backups for edited files
- Role-based restrictions for development tools
- Permission matrix self-check with `python xjlagent.py --permission-check`

## Role model

JL-Agent is designed for shared use, not just single-user tinkering:

- `admin`: full tool access, user management, development tools, command execution, code edits, and shared knowledge maintenance.
- `maintainer`: safe assistant workflows plus approved shared knowledge ingestion.
- `viewer`: safe chat, search, document analysis, and model-only research workflows.

Both the terminal UI and dashboard route tool calls through the same permission checks.

See [PERMISSION_MATRIX.md](PERMISSION_MATRIX.md) for the tool-group matrix and enforcement points.

## Dangerous command blocking

Examples of blocked operations:

- Recursive deletion of high-risk paths
- Disk formatting tools
- `git reset --hard`
- `git clean -fdx`
- Download-and-execute shell patterns
- Encoded PowerShell commands

Administrators can override with:

```text
ALLOW_DANGEROUS: <command>
```

or:

```text
JL_AGENT_ALLOW_DANGEROUS=1
```

## What it does not provide

- Kernel-level isolation
- Container isolation
- Cloud-managed execution sandboxes
- Enterprise endpoint policy enforcement
- Data loss prevention outside OS-level permissions

Use VM/container/endpoint controls when stronger isolation is required.
