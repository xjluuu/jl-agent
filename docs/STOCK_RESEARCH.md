# Stock Research Bridge

JL-Agent can optionally bridge to an existing local `stock_research` project that generates a daily A-share multi-agent research report.

This bridge does not require a fixed drive letter or a hardcoded folder. Configure the path in `myagent_config.json` or with environment variables.

If an existing JL-Agent `cron_jobs.json` already contains a `stock_research` task, JL-Agent will try to infer the folder from that cron command.

## Expected Folder

```text
stock_research/
  agents/
    orchestrator.py
  cron_feedback/
    latest.txt
  daily_output.txt
```

`agents/orchestrator.py` is used when an admin runs the report generator. `cron_feedback/latest.txt` or `daily_output.txt` is used when users read the latest report.

## Config

```json
"stock_research": {
  "dir": "path/to/stock_research",
  "python": "",
  "cron": "30 15 * * 1-5",
  "job_name": "A股投研日报"
}
```

Environment overrides:

```text
JL_AGENT_STOCK_RESEARCH_DIR
JL_AGENT_STOCK_RESEARCH_PYTHON
JL_AGENT_STOCK_RESEARCH_CRON
JL_AGENT_STOCK_RESEARCH_JOB
```

## Commands

```text
/stock
/stock run
/stock install
```

`/stock` is read-only and can be used by normal viewers. `/stock run` and `/stock install` are admin-only.

## Windows EXE Notes

View-only users do not need Python. They only need access to the report folder.

Admins need Python only when running `orchestrator.py` or installing the cron job. In EXE deployments, set `stock_research.python` to the Python executable on the admin machine, for example:

```json
"python": "C:\\Python311\\python.exe"
```

## Safety

This feature is for research workflow support only. It is not financial advice, trading automation, or a promise of investment results.
