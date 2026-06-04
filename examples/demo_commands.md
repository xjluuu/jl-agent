# Demo Commands

Run these from the repository root.

## Health checks

```bash
python xjlagent.py --version
python xjlagent.py --self-check
python xjlagent.py --release-check
```

## Engineering workflow

```bash
python xjlagent.py --project-scan
python xjlagent.py --worktree-status
python xjlagent.py --verify-suggestions
python xjlagent.py --run-verify
python xjlagent.py --audit-log
```

## Interactive commands

```text
/project
/changes
/verify
/plan new Demo
/plan add Run self-check
/plan done 1
/audit 20
```

## Research workflows

In interactive mode, ask for a multi-angle research split:

```text
Use parallel research to analyze this company from five angles:
fundamentals, recent news, valuation, policy/regulatory risk, and questions I should verify before making any decision.
```

For a stricter finance-style review:

```text
Use risk-veto research to analyze this stock.
Run separate tracks for fundamentals, recent filings, news catalysts, valuation, liquidity, and regulatory risk.
Then run an independent Risk Agent. If any red flag is serious enough, return veto=true and explain the veto reasons.
```

For an optional local A-share daily report bridge:

```text
/stock
/stock run
/stock install
```

For local files:

```text
Analyze this folder of PDFs, spreadsheets, and notes.
Find the most important documents, summarize the risks, and suggest which files should be added to the shared knowledge base.
```

For team permissions:

```text
/admin list
/admin allow alice
/admin block alice
```

## Windows packaging

```bat
build_xjlagent_exe.bat --no-pause
dist\xjlagent.exe --self-check
```
