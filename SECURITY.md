# Security Policy

## Supported Versions

Security fixes are accepted for the latest public release.

## Reporting a Vulnerability

Please do not disclose exploitable details in a public issue.

Preferred process:

1. Open a private security advisory if the repository has advisories enabled.
2. Otherwise, contact the maintainer through the public profile contact method.
3. Include reproduction steps, affected version, expected impact, and suggested mitigation if known.

## Secrets

Never commit:

- API keys
- `myagent_config.json`
- `.env` files
- Runtime databases
- Audit logs
- Company documents
- Packaged `dist/` output
- Local wheels

Run before pushing:

```bash
python xjlagent.py --release-check
```

## Runtime Safety

JL-Agent includes local guardrails:

- Dangerous command blocking
- Tool audit logs
- Secret redaction for common patterns
- Patch/file-write diffs
- Backups for edited files

These guardrails are not a full OS sandbox. Use a VM, restricted account, or enterprise endpoint controls for stronger isolation.
