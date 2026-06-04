# JL-Agent

[English](README.md) | [简体中文](README.zh-CN.md)

**一个面向受限企业环境的单文件本地 AI Agent，支持跨平台 Python 运行，也支持打包成 Windows EXE。**

JL-Agent 面向一种很常见但经常被开源工具忽略的环境：公司电脑权限受限、不能依赖 Docker、不能依赖公网插件市场、模型可能走内网网关、部分同事没有 Python 环境，但仍然需要一个可用、可审计、可配置的本地 AI 助手。

## 它和普通 Agent 有什么区别

JL-Agent 不是单纯的聊天壳，而是一个面向企业内实际工作的本地 Agent：

- **权限分层**：管理员可以使用开发和命令工具；维护员可以投喂共享知识库；普通用户只能使用安全的问答、搜索、资料分析和研究流程。
- **多 Agent 并行研究**：`parallel_research` 可以把一个主题拆成多个研究问题并发分析，适合行业、政策、股市、竞品、风险等多角度研究。
- **Risk Agent 一票否决**：`risk_veto_research` 会在并行研究后单独跑风险审查；只要触发红线，就返回 `veto: true`。
- **A 股投研日报桥接**：`stock_market_report` 可以读取本地 `stock_research` 每日多 Agent 投研日报；管理员可以用 `stock_market_run_daily` 手动运行，或用 `stock_market_install_cron` 恢复定时任务。
- **金融/股市研究场景**：可以整理股票研究笔记、公司公告、新闻、风险因素、表格数据和内部研究资料，辅助形成结构化分析。
- **企业部署友好**：一个 Python 文件即可运行，也可以打包成 Windows EXE；API 配置、模型名、个人目录、共享目录都可以外部配置。
- **可审计**：工具调用写入审计日志，常见密钥会脱敏，文件写入返回 diff，危险命令会被拦截。
- **本地资料理解**：`analyze_folder` 和 `study_files` 可以梳理 PDF、Office 文档、表格、日志、代码和笔记，不需要把整批原文直接塞进上下文。

## 适用场景

- macOS、Windows、Linux 上直接运行 Python 版
- Windows 用户没有 Python 时，打包成 `.exe` 分发
- API 地址、Key、模型名通过外部 JSON 或环境变量配置
- 公司内网模型网关、离线依赖包、共享存储路径
- 本地审计日志、权限控制、知识库导入、项目扫描、补丁 diff、验证流程

## 示例工作流

股市/行业研究：

```text
用 /stock 查看最新 A 股多 Agent 投研日报。
管理员可用 /stock run 手动生成日报，或用 /stock install 恢复工作日定时任务。

带 Risk Agent 一票否决的研究：
1. 公司基本面和近期公告
2. 新闻、政策和事件催化
3. 估值和同行对比
4. 主要风险和数据缺口
5. 独立 Risk Agent 是否 veto
```

内部资料分析：

```text
分析这个文件夹里的 PDF、表格和会议纪要。
找出重点文件，汇总风险，并建议哪些内容应该沉淀到共享知识库。
```

团队权限：

```text
管理员：完整工具、开发能力、用户管理
维护员：可维护共享知识库
普通用户：安全问答、搜索、资料分析、研究流程
```

## 快速开始

```bash
python -m pip install -r requirements.txt
python xjlagent.py --init-config
python xjlagent.py --self-check
python xjlagent.py
```

常用维护命令：

```bash
python xjlagent.py --version
python xjlagent.py --config-path
python xjlagent.py --print-config
python xjlagent.py --project-scan
python xjlagent.py --worktree-status
python xjlagent.py --permission-check
python xjlagent.py --run-verify
python xjlagent.py --dashboard
```

离线成熟度检查：

```bash
python tests/offline_smoke.py
```

这个 smoke test 不调用模型 API，用于检查免费开源状态、角色权限、自检、发布检查和本地验证建议。

## 路径配置

JL-Agent 不要求固定盘符，也不假设必须有某个共享盘。默认会使用当前用户的数据目录，并可以通过下面环境变量覆盖：

- `JL_AGENT_HOME`：个人和共享数据使用同一个目录
- `JL_AGENT_PERSONAL_DIR`：个人配置、记忆、计划任务
- `JL_AGENT_SHARE_DIR`：共享用户、共享技能、共享知识库
- `JL_AGENT_STOCK_RESEARCH_DIR`：可选，A 股投研日报目录
- `JL_AGENT_STOCK_RESEARCH_PYTHON`：可选，管理员机器运行日报脚本时使用的 Python
- `JL_AGENT_STOCK_RESEARCH_CRON`：可选，默认 `30 15 * * 1-5`
- `JL_AGENT_STOCK_RESEARCH_JOB`：可选，默认 `A股投研日报`

可选 A 股投研桥接配置：

```json
"stock_research": {
  "dir": "path/to/stock_research",
  "python": "",
  "cron": "30 15 * * 1-5",
  "job_name": "A股投研日报"
}
```

`dir` 下面应有 `agents/orchestrator.py` 或 `orchestrator.py`。普通用户只看最新报告时不需要 Python；只有管理员手动运行日报或安装定时任务时才需要 Python。

可选 A 股投研桥接的详细说明见 [docs/STOCK_RESEARCH.md](docs/STOCK_RESEARCH.md)。

JL-Agent 可以免费运行。普通终端 UI 不再要求试用、付款或激活码。

Windows 示例：

```bat
set JL_AGENT_PERSONAL_DIR=%LOCALAPPDATA%\JL-Agent
set JL_AGENT_SHARE_DIR=\\fileserver\jl-agent
```

macOS/Linux 示例：

```bash
export JL_AGENT_HOME="$HOME/.local/share/jl-agent"
```

## Windows EXE

在 Windows 打包机上：

```bat
python -m pip install -r requirements-build.txt
build_xjlagent_exe.bat --no-pause
dist\xjlagent.exe --self-check
```

离线环境可以先在有网络的机器上准备依赖：

```bat
prepare_offline_wheels.bat
```

如果目标用户是普通 Intel/AMD Windows 电脑，请在 Windows x64 机器上打包。

## 官网页面

项目介绍网站源码在 [site/](site/)。仓库内置 GitHub Pages workflow，推送到 `main` 后可以自动发布这个目录。

## 免费开源

JL-Agent 使用 MIT 许可证开源，可以免费使用、修改、打包成 Windows EXE，并按你自己的内部环境调整。

Bug、功能建议、文档改进和可复现的打包问题可以走 GitHub Issues。不要在公开 issue 里贴 API Key、公司文档、内网细节、客户数据或其他保密资料。

金融/股市相关能力只用于研究辅助。JL-Agent 不提供投资建议，不执行交易，也不能替代公司合规审查。

## 智能体成熟方向

JL-Agent 会继续按“受限企业环境里的本地工作 Agent”发展，而不是做云端平台的简单平替。近期重点是可靠性、权限安全、任务执行闭环、多 Agent 研究，以及 Windows EXE 交付质量。

相关文档：

- [Agent Maturity Plan](docs/AGENT_MATURITY_PLAN.md)
- [Permission Matrix](docs/PERMISSION_MATRIX.md)
- [Task Execution Loop](docs/TASK_EXECUTION_LOOP.md)
- [Safety Model](docs/SAFETY_MODEL.md)

## 安全说明

不要提交真实 API Key、运行时配置、数据库、日志、公司文档或知识库文件。公开仓库只应包含源码、文档、示例配置和打包脚本。

金融/股市相关能力用于整理和分析信息，不是投资建议，也不是自动交易系统。Risk Agent 的一票否决是研究控制机制，不是投资推荐。

## 许可证

MIT。见 [LICENSE](LICENSE)。
