# Task Execution Loop

JL-Agent should not handle substantial work as a single chat answer. For engineering, packaging, data-cleanup, document-processing, and operations tasks, it should follow a visible loop.

## Standard loop

1. Context

Scan the project, folder, files, or current runtime state before changing anything. For code projects, start with `project_scan` and `worktree_status` when available.

2. Plan

Create or update `task_plan` with small ordered steps. Exactly one active step should be `in_progress`.

Use:

```text
/plan loop <title>
```

or call `task_plan` with:

```json
{"action": "loop", "text": "title"}
```

3. Execute

Make the smallest scoped change for the current step. Do not modify unrelated files, private runtime data, or user changes outside the task.

4. Verify

Run the smallest useful verification. Examples:

- `python xjlagent.py --self-check`
- `python xjlagent.py --release-check`
- `python tests/offline_smoke.py`
- `python xjlagent.py --run-verify`
- project-specific build or test commands suggested by `verify_suggestions`

5. Risk summary

Final output should include:

- what changed
- what was verified
- what could not be verified
- remaining risks or assumptions

## Non-admin behavior

Viewer and Maintainer users cannot use engineering tools. For those roles, JL-Agent should refuse development or command-execution tasks and explain that Admin access is required.

## Why this matters

This loop is the difference between a chat toy and a local work agent. It makes work inspectable, repeatable, and safer in restricted company environments.

