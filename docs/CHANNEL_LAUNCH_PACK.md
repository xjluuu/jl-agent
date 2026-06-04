# Channel Launch Pack

Use this order first:

1. V2EX: get fast feedback from technical users.
2. OSCHINA: create a Chinese open-source listing with long-tail search value.
3. Upwork / Fiverr: convert the same positioning into paid setup services.
4. Hacker News / Product Hunt: wait until the demo video and first user feedback are ready.

## V2EX

Recommended node:

```text
分享创造
```

Title:

```text
我开源了 JL-Agent：一个能打包成 EXE、带权限和审计的本地 AI Agent，适合公司内网环境
```

Body:

```text
我最近把自己用的一个本地 AI Agent 整理成开源项目了，叫 JL-Agent。

GitHub:
https://github.com/xjluuu/jl-agent

官网:
https://xjluuu.github.io/jl-agent/

它不是想做一个新的云端 Agent 平台，而是针对一个比较具体的场景：公司电脑权限受限、同事不一定有 Python、不能依赖 Docker 或公网插件市场、模型可能走内网网关，但团队仍然想要一个能落地的本地 AI 助手。

目前的特点：

- 一个主 Python 文件，方便审查和内部分发
- 可跨平台 Python 运行，也可以在 Windows 打包成 EXE
- API 地址、Key、模型名、个人目录、共享目录都放在外部配置里，不需要重新打包
- Admin / Maintainer / Viewer 权限分层
- 工具调用审计日志、密钥脱敏、危险命令默认拦截
- 本地文件夹、PDF、Office、表格、代码和笔记分析
- 多 Agent 并行研究
- Risk Agent 一票否决的研究流程
- 可选 A 股投研日报桥接，/stock 可以读本地每日多 Agent 报告
- 支持受限网络和离线依赖包思路

它和 Codex、Claude Code 这类平台不是一个层级：平台能力、云端沙箱、OAuth 插件市场这些不是单文件 EXE 能完整复刻的。JL-Agent 更偏向“内网能跑、可配置、可审计、能交付给普通同事使用”的本地工作台。

我比较想听听大家对这几个点的建议：

1. 单文件 Agent 开源时，哪些安全边界最应该优先加强？
2. Windows EXE 分发给公司普通用户时，哪些交接文档最关键？
3. 这种“内网落地型 Agent”有没有更适合的定位或功能重点？

金融/股市相关功能只做研究辅助，不是投资建议，也不是自动交易系统。

如果有团队想直接试部署，我也放了 paid setup request 入口，但这帖主要还是想先收集产品和工程建议。

国内付费部署可以在确认范围后用支付宝或微信支付，公开 issue 里不要贴收款码、密钥或公司资料。
```

## OSCHINA

Software name:

```text
JL-Agent
```

One-line description:

```text
面向受限企业环境的单文件本地 AI Agent，支持 Windows EXE 分发、权限分层、审计日志和多 Agent 研究流程。
```

Tags:

```text
AI Agent, Python, Windows EXE, 企业内网, 本地部署, 权限管理, 审计日志, 多 Agent, 金融研究
```

Project URL:

```text
https://github.com/xjluuu/jl-agent
```

Homepage:

```text
https://xjluuu.github.io/jl-agent/
```

Long description:

```text
JL-Agent 是一个面向受限企业环境的本地 AI Agent。它适合公司电脑权限受限、不能依赖 Docker、不能依赖公网插件市场、部分同事没有 Python、模型需要走内网网关的场景。

项目核心目标不是替代云端 Agent 平台，而是把本地可运行、外部可配置、可打包、可审计、可交接这些落地问题解决好。

主要能力：
- 单 Python 文件运行，便于审查和部署
- 支持 macOS / Windows / Linux Python 模式
- 支持 Windows EXE 打包，方便分发给没有 Python 的用户
- API 地址、Key、模型名、个人目录、共享目录外部配置
- Admin / Maintainer / Viewer 权限分层
- 工具调用审计日志、密钥脱敏、危险命令拦截
- 本地文档、文件夹、表格、代码和笔记分析
- 项目扫描、diff、验证建议等工程辅助能力
- 多 Agent 并行研究
- Risk Agent 一票否决研究流程
- 可选 A 股投研日报桥接，普通用户可以只读 /stock 报告

金融/股市能力只用于资料整理和研究辅助，不构成投资建议，也不是自动交易系统。
```

## Upwork / Fiverr

Gig title:

```text
I will deploy a local AI agent for restricted company Windows environments
```

Short subtitle:

```text
Windows EXE packaging, internal model config, role permissions, audit logs, and local research workflows.
```

Overview:

```text
I help teams deploy JL-Agent, an open-source local AI agent designed for restricted company environments where Docker, public plugin marketplaces, full internet access, or Python on every user machine may not be available.

This service is for practical deployment work: Windows EXE packaging, external configuration, internal model gateway setup, personal/shared storage layout, role-based Admin/Maintainer/Viewer permissions, audit log configuration, safe command controls, and optional stock or market research workflow setup.

JL-Agent is open source. You can use it for free. This paid service is for teams that want a working deployment plan, checked configuration, and handover notes instead of figuring everything out alone.

Financial and market workflows are research support only. I do not provide investment advice and I do not build automated trading systems.

China-based clients can use Alipay or WeChat Pay after the scope is confirmed. International payment methods can be agreed separately.
```

Package 1:

```text
Starter Setup - $99
- Review your target runtime: Python mode or Windows EXE
- Run self-check / release-check guidance
- Configure API URL, model, storage paths, and basic user roles
- Provide short handover notes
Delivery: 2-3 days
```

Package 2:

```text
Deployment Setup - $299
- Everything in Starter Setup
- Windows EXE packaging checklist
- Internal model gateway configuration guidance
- Admin / Maintainer / Viewer permission map
- Audit log and safe command settings
- Offline or restricted-network deployment notes
Delivery: 4-5 days
```

Package 3:

```text
Enterprise Pilot - $499+
- Everything in Deployment Setup
- Shared storage layout
- Team handover checklist
- Optional /stock report bridge validation
- Parallel research or Risk Agent veto workflow configuration
- Pilot rollout notes for a small team
Delivery: 5-10 days depending on scope
```

Buyer requirements:

```text
1. Target OS: Windows 10, Windows 11, macOS, or Linux?
2. Do end users have Python, or do you need Windows EXE?
3. Is the model endpoint public API or internal gateway?
4. Do you need personal and shared storage paths?
5. Do you need role-based permissions?
6. Do you need stock/market research workflow support?
7. Do you have restricted internet or offline dependency requirements?
8. Do not send secrets, API keys, private company documents, or production data in the first message.
```

## Hacker News

Use after a demo video or first external feedback.

Title:

```text
Show HN: JL-Agent - local-first AI agent for restricted company environments
```

Body:

```text
I built JL-Agent for a deployment environment I do not see many AI tools optimize for: restricted company computers, no Docker assumption, internal model gateways, users without Python, and a need for local config and audit logs.

It is a single Python file that can also be packaged into a Windows EXE. It includes role-based permissions, local audit logs, dangerous command blocking, document/folder analysis, project scan and diff helpers, parallel research, a Risk Agent veto workflow, and an optional bridge to local stock-market research reports.

It is not trying to replace hosted platforms like Codex. It focuses on what can actually be shipped in locked-down company environments.

I would appreciate feedback on the safety model, EXE deployment flow, and enterprise handover docs.
```

## Product Hunt

Use only after:

- Demo video is ready
- README screenshots are stronger
- At least one external user has tried the setup
- Website has a short installation walkthrough

Tagline:

```text
Local-first AI agent for restricted company environments.
```

Launch copy:

```text
JL-Agent helps teams run a practical local AI assistant where Docker, public plugin marketplaces, unrestricted internet, or Python on every coworker's machine are not realistic assumptions.
```
