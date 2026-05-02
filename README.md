# 全市场 AH 股 DCF 估值计算系统设计方案

## 1. 项目背景

本项目旨在设计一个能够覆盖 A 股与 H 股市场的自动化 DCF（Discounted Cash Flow，现金流折现）估值计算系统，为投研、量化选股、估值监控和投资决策提供系统化的内在价值参考。

考试要求为提交完整设计方案至 GitHub 或 Gitee，本仓库不包含具体业务代码实现，重点展示系统架构设计、数据流程设计、DCF 估值逻辑、数据库设计、协作规范与项目管理方案。

## 2. 业务目标

系统目标是：

- 自动化获取 A 股与 H 股股票基础信息、财务报表、市场行情和估值参数；
- 对不同市场、行业和公司类型采用统一但可配置的 DCF 估值框架；
- 支持批量计算全市场股票的内在价值、估值偏离度和核心假设参数；
- 将估值结果存储到数据库，便于查询、回测、展示和下游投资决策使用；
- 通过配置文件管理运行范围、数据源、估值假设和调度参数；
- 通过标准化协作规范保证方案可维护、可扩展、可复现。

## 3. 仓库结构

```text
AH_DCF_Valuation_System/
├── README.md
├── PROJECT_STRUCTURE.md
├── docs/
│   ├── 01_business_requirement.md
│   ├── 02_system_architecture.md
│   ├── 03_data_flow.md
│   ├── 04_dcf_methodology.md
│   ├── 05_database_design.md
│   ├── 06_batch_scheduling.md
│   ├── 07_risk_control_and_validation.md
│   ├── 08_submission_guide.md
│   └── diagrams/
│       ├── architecture.mmd
│       └── data_flow.mmd
├── data_contracts/
│   ├── stock_master_contract.md
│   ├── financial_statement_contract.md
│   ├── market_data_contract.md
│   └── valuation_result_contract.md
├── config/
│   ├── system_config_template.yaml
│   └── valuation_assumption_template.yaml
├── examples/
│   ├── sample_run_plan.md
│   └── sample_output_table.md
├── governance/
│   ├── collaboration_standard.md
│   ├── branch_strategy.md
│   ├── commit_convention.md
│   └── review_checklist.md
└── templates/
    ├── issue_template.md
    └── pull_request_template.md
```

## 4. 系统模块总览

系统设计分为七个核心模块：

| 模块 | 职责 |
|---|---|
| 配置管理模块 | 管理市场范围、股票池、数据源、估值参数和运行频率 |
| 数据采集模块 | 获取 A 股、H 股基础信息、行情数据、财务报表和宏观参数 |
| 数据清洗模块 | 统一字段、币种、会计期间、缺失值和异常值处理 |
| 财务预测模块 | 基于历史收入、利润、资本开支、营运资本等生成自由现金流预测 |
| DCF 估值模块 | 根据 WACC、终端增长率和预测期现金流计算企业价值和每股内在价值 |
| 结果存储模块 | 将原始数据、中间结果、核心假设和最终估值结果写入数据库 |
| 监控与报告模块 | 输出运行日志、异常股票清单、估值结果表和质量检查报告 |

## 5. DCF 核心公式

系统采用 FCFF（Free Cash Flow to Firm，公司自由现金流）折现模型：

```text
Enterprise Value = Σ FCFF_t / (1 + WACC)^t + Terminal Value / (1 + WACC)^n
Terminal Value = FCFF_n × (1 + g) / (WACC - g)
Equity Value = Enterprise Value - Net Debt + Cash Adjustments
Intrinsic Value per Share = Equity Value / Shares Outstanding
Valuation Gap = Intrinsic Value per Share / Market Price - 1
```

其中：

- `FCFF_t`：第 t 年公司自由现金流；
- `WACC`：加权平均资本成本；
- `g`：终端增长率；
- `n`：显式预测期年数；
- `Net Debt`：有息负债减去现金及现金等价物；
- `Shares Outstanding`：总股本或流通股本，可根据配置选择。

详细方法见 `docs/04_dcf_methodology.md`。

## 6. 数据流程概览

```text
股票池配置
   ↓
基础信息采集
   ↓
行情数据采集
   ↓
财务报表采集
   ↓
数据清洗与标准化
   ↓
自由现金流预测
   ↓
WACC 与终端增长率估计
   ↓
DCF 估值计算
   ↓
结果校验
   ↓
数据库入库与报告输出
```

## 7. 数据源设计

项目设计支持多数据源扩展：

| 数据类别 | A 股建议数据源 | H 股建议数据源 | 说明 |
|---|---|---|---|
| 股票基础信息 | Baostock、AkShare、Tushare | AkShare、港交所公开数据、Yahoo Finance | 股票代码、上市状态、行业等 |
| 日行情数据 | Baostock、AkShare、Tushare | Yahoo Finance、AkShare | 收盘价、市值、成交额等 |
| 财务报表 | Tushare、AkShare、交易所公告 | Yahoo Finance、港交所公告、企业年报 | 利润表、资产负债表、现金流量表 |
| 无风险利率 | 中债、国债收益率 | 香港政府债券收益率、美债收益率 | 用于权益资本成本估计 |
| 市场风险溢价 | 内部配置、研究假设 | 内部配置、研究假设 | 可配置参数 |

## 8. 评分标准对应说明

| 评分项 | 权重 | 本仓库对应内容 |
|---|---:|---|
| 架构设计 | 40% | `docs/02_system_architecture.md`、架构图、模块拆分、数据库设计 |
| 数据流程 | 30% | `docs/03_data_flow.md`、数据契约、清洗规则、校验逻辑 |
| 协作规范 | 30% | `governance/`、Issue/PR 模板、分支规范、提交规范、Review Checklist |

## 9. 推荐提交方式

1. 将本文件夹上传到 GitHub 或 Gitee；
2. 仓库名称建议使用 `AH_DCF_Valuation_System_Design`；
3. 提交前检查 README 能否完整说明项目背景、架构和数据流程；
4. 确保所有 Markdown 文档均可直接在线阅读；
5. 在提交说明中强调：本仓库为系统设计方案，不包含具体代码实现。

## 10. 适用场景

- 投研部门批量估值；
- 量化策略中的估值因子构建；
- 股票池筛选与估值偏离监控；
- 财务预测模型与 DCF 模型结合；
- A/H 两地上市公司估值比较。
