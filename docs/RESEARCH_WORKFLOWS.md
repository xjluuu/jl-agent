# Research Workflows

JL-Agent's research features are intended for structured analysis, not autonomous trading, investment advice, or local command execution.

## Built-in templates

List available templates:

```bash
python xjlagent.py --research-templates
```

Show one template:

```bash
python xjlagent.py --research-template stock
python xjlagent.py --research-template company_due_diligence
python xjlagent.py --research-template internal_project
```

Interactive mode:

```text
/researchtemplates
/researchtemplates stock
```

## Stock research template

Use the stock template when you want a repeatable research structure around:

- business and financial fundamentals
- recent announcements and news
- valuation and peer comparison
- catalyst and policy review
- independent Risk Agent veto rules

The Risk Agent is a research control. It can flag missing data, compliance concerns, overconfident claims, and red-line risks. It does not make investment recommendations or place trades.

## Due diligence template

Use the due-diligence template for company, vendor, partner, or target analysis. It is designed to separate:

- business model and operating facts
- legal, compliance, and reputational risks
- financial and operational dependencies
- evidence gaps
- next questions for a human reviewer

## Internal project template

Use the internal-project template for operations, automation, deployment, and lightweight system planning. It focuses on:

- current state
- stakeholders
- constraints
- implementation steps
- verification
- rollout risk

## Connecting templates to tools

Model-only research tools are available to all roles:

- `parallel_research`
- `risk_veto_research`
- `stock_market_report`

Admin-only stock actions are separated because they can run local scripts or install scheduled jobs:

- `stock_market_run_daily`
- `stock_market_install_cron`

See [PERMISSION_MATRIX.md](PERMISSION_MATRIX.md) for role boundaries.

## Safety language

Financial workflows are research support only. JL-Agent does not provide investment advice, does not place trades, and does not replace compliance review.

