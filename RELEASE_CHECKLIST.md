# Release Checklist

## Before first public push

- [ ] Review `xjlagent.py` for personal/company-specific strings.
- [ ] Run `python xjlagent.py --self-check`.
- [ ] Run `python xjlagent.py --permission-check`.
- [ ] Run `python xjlagent.py --onboarding`.
- [ ] Run `python xjlagent.py --exe-check`.
- [ ] Run `python xjlagent.py --release-check`.
- [ ] Run `python tests/offline_smoke.py`.
- [ ] Run `python xjlagent.py --run-verify`.
- [ ] Review `python xjlagent.py --research-templates`.
- [ ] Confirm no `myagent_config.json`, `.myagent/`, business documents, logs, databases, `dist/`, `build/`, or `wheels/` are staged.
- [ ] Confirm no payment, funding, or private support links are staged.
- [ ] Add real screenshots or GIFs under `screenshots/`.
- [ ] Decide the public repository name.
- [ ] Create GitHub repository.
- [ ] Add repository topics.

Recommended topics:

```text
ai-agent
local-agent
offline-ai
windows
enterprise
python
pyinstaller
automation
audit-log
knowledge-base
```

## First release

- [ ] Tag `v0.1.0`.
- [ ] Create GitHub Release.
- [ ] Upload Windows x64 EXE if built on Windows x64.
- [ ] Run `dist\xjlagent.exe --self-check`, `--permission-check`, `--exe-check`, and `--onboarding` before uploading an EXE.
- [ ] Include known limitations.
- [ ] Link demo GIF or screenshot.

## First launch posts

- [ ] GitHub Discussions or README announcement
- [ ] X / Twitter
- [ ] Reddit relevant communities
- [ ] Hacker News Show HN
- [ ] V2EX or local developer community
- [ ] Personal blog or newsletter
