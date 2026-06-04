# Post Templates

## Short post

I built JL-Agent: a one-file local AI agent for restricted enterprise environments, with optional Windows EXE deployment.

- Runs from one Python file
- Runs with Python on macOS, Windows, and Linux
- Can be packaged into a Windows EXE
- External JSON config
- Role-based permissions
- Parallel research for finance/market/company analysis
- Risk Agent one-vote veto workflow
- Local audit log
- Dangerous command blocking
- Project scan + verification workflow
- No Docker required

GitHub: https://github.com/xjluuu/jl-agent
Website: https://xjluuu.github.io/jl-agent/

## Hacker News

Title:

```text
Show HN: JL-Agent - a one-file local AI agent for restricted enterprise environments
```

Body:

```text
I built JL-Agent for a very specific environment: restricted company computers where public internet may be blocked, Docker is not available, some coworkers may not have Python, and AI tools need local config and auditability.

It is a single Python file that can be packaged into an EXE. It includes self-checks, external JSON config, role-based permissions, local memory/skills, audit logs, dangerous command blocking, folder/document analysis, parallel research, a Risk Agent veto workflow, project scanning, patch diffs, and a verification workflow.

It is not meant to replace hosted tools like Codex. It is meant for the awkward enterprise environments where hosted developer agents are hard to deploy.

Feedback on packaging, safety model, and enterprise deployment docs would be especially useful.
```

## Reddit / community post

```text
I have been working on a local AI agent designed for restricted company environments.

The goal is not to be a cloud agent framework. It is a practical single-file assistant that can be packaged as an EXE and run where coworkers do not have Python, public internet may be blocked, and audit logs matter.

Features:
- one-file Python runtime
- Cross-platform Python mode
- Windows EXE build
- external config
- role-based admin / maintainer / viewer permissions
- parallel research for market/company/document analysis
- Risk Agent one-vote veto for research red flags
- local audit log
- dangerous command blocking
- project scan / diff / verification helpers
- optional dashboard

I would appreciate feedback from anyone who has tried deploying AI tools inside restricted company networks.

GitHub: https://github.com/xjluuu/jl-agent
Website: https://xjluuu.github.io/jl-agent/
```

## Community follow-up

```text
JL-Agent is free and open source under the MIT license.

If you try it in a restricted company environment, useful feedback would be:
- whether Python mode or Windows EXE mode worked
- what config or path assumptions did not fit your environment
- whether the Admin / Maintainer / Viewer permissions were understandable
- whether the audit log and dangerous-command blocking covered your risk concerns
- what examples would make internal deployment easier

GitHub Issues: https://github.com/xjluuu/jl-agent/issues
```

See [CHANNEL_LAUNCH_PACK.md](CHANNEL_LAUNCH_PACK.md) for V2EX, OSCHINA, Hacker News, and Product Hunt copy.
