# 项目文件结构说明

本项目以“设计方案”为核心，不包含具体生产代码。文件夹设计模拟真实工程项目，以便体现架构完整性、数据流程清晰性和协作规范性。

## 顶层文件

| 文件/目录 | 作用 |
|---|---|
| `README.md` | 项目总览、业务目标、模块说明和评分标准对应 |
| `PROJECT_STRUCTURE.md` | 当前文件，解释仓库结构 |
| `docs/` | 核心设计文档 |
| `data_contracts/` | 数据表和字段级数据契约 |
| `config/` | 系统配置模板和估值参数模板 |
| `examples/` | 示例运行计划和估值结果表样例 |
| `governance/` | 协作规范、分支规范、提交规范和评审清单 |
| `templates/` | Issue 与 Pull Request 模板 |

## 文档阅读顺序

建议评审老师按照以下顺序阅读：

1. `README.md`
2. `docs/01_business_requirement.md`
3. `docs/02_system_architecture.md`
4. `docs/03_data_flow.md`
5. `docs/04_dcf_methodology.md`
6. `docs/05_database_design.md`
7. `governance/collaboration_standard.md`
8. `docs/08_submission_guide.md`

## 设计重点

本项目重点不在于单一 DCF 公式，而在于把 DCF 估值工程化，包括：

- 如何管理不同市场股票池；
- 如何统一 A 股与 H 股数据；
- 如何处理财务报表频率、币种、缺失值和异常值；
- 如何让 WACC、终端增长率、预测期假设可配置；
- 如何存储估值结果和中间假设；
- 如何支持批量运行、异常监控和团队协作。
