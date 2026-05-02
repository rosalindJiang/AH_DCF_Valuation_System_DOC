# 05 数据库设计

## 1. 数据库设计目标

数据库需要同时保存原始数据、清洗后数据、中间计算结果、估值假设和最终估值结果，使系统具备可追溯性和可复现性。

## 2. 数据表总览

| 表名 | 作用 |
|---|---|
| stock_master | 股票基础信息表 |
| market_daily | 日行情数据表 |
| financial_statement | 财务报表标准化表 |
| macro_assumption | 宏观与市场参数表 |
| valuation_assumption | 个股估值假设表 |
| fcff_forecast | 自由现金流预测表 |
| valuation_result | DCF 最终估值结果表 |
| data_quality_report | 数据质量报告表 |
| job_run_log | 批量任务运行日志表 |

## 3. 核心表设计

### 3.1 stock_master

| 字段 | 类型 | 说明 |
|---|---|---|
| stock_code | varchar | 股票代码，主键 |
| stock_name | varchar | 股票名称 |
| market | varchar | A_SHARE 或 H_SHARE |
| exchange | varchar | 交易所 |
| industry | varchar | 行业 |
| currency | varchar | 交易币种 |
| listing_status | varchar | 上市状态 |
| is_ah_dual_listed | boolean | 是否 A/H 双重上市 |
| update_time | datetime | 更新时间 |

### 3.2 market_daily

| 字段 | 类型 | 说明 |
|---|---|---|
| trade_date | date | 交易日期 |
| stock_code | varchar | 股票代码 |
| close_price | decimal | 收盘价 |
| market_cap | decimal | 总市值 |
| shares_outstanding | decimal | 总股本 |
| turnover | decimal | 成交额 |
| currency | varchar | 行情币种 |
| data_source | varchar | 数据来源 |

联合主键：`trade_date + stock_code`。

### 3.3 financial_statement

| 字段 | 类型 | 说明 |
|---|---|---|
| stock_code | varchar | 股票代码 |
| report_date | date | 报告期 |
| fiscal_year | int | 会计年度 |
| statement_type | varchar | annual、quarterly、ttm |
| revenue | decimal | 营业收入 |
| ebit | decimal | EBIT |
| tax_expense | decimal | 所得税费用 |
| depreciation_amortization | decimal | 折旧摊销 |
| capex | decimal | 资本开支 |
| operating_cash_flow | decimal | 经营现金流 |
| cash | decimal | 现金及现金等价物 |
| total_debt | decimal | 有息负债 |
| currency | varchar | 报表币种 |
| data_source | varchar | 数据来源 |

### 3.4 valuation_assumption

| 字段 | 类型 | 说明 |
|---|---|---|
| valuation_date | date | 估值日期 |
| stock_code | varchar | 股票代码 |
| forecast_years | int | 显式预测期 |
| revenue_growth_method | varchar | 收入增长率估计方法 |
| wacc | decimal | WACC |
| risk_free_rate | decimal | 无风险利率 |
| beta | decimal | Beta |
| market_risk_premium | decimal | 市场风险溢价 |
| cost_of_debt | decimal | 债务成本 |
| tax_rate | decimal | 税率 |
| terminal_growth_rate | decimal | 终端增长率 |
| scenario | varchar | conservative、base、optimistic |
| parameter_version | varchar | 参数版本 |

### 3.5 fcff_forecast

| 字段 | 类型 | 说明 |
|---|---|---|
| valuation_date | date | 估值日期 |
| stock_code | varchar | 股票代码 |
| forecast_year | int | 预测年份 |
| forecast_revenue | decimal | 预测收入 |
| forecast_ebit | decimal | 预测 EBIT |
| forecast_tax | decimal | 预测税费 |
| forecast_da | decimal | 预测折旧摊销 |
| forecast_capex | decimal | 预测资本开支 |
| forecast_delta_nwc | decimal | 预测营运资本变动 |
| forecast_fcff | decimal | 预测 FCFF |
| discount_factor | decimal | 折现因子 |
| present_value_fcff | decimal | FCFF 现值 |

### 3.6 valuation_result

| 字段 | 类型 | 说明 |
|---|---|---|
| valuation_date | date | 估值日期 |
| stock_code | varchar | 股票代码 |
| market | varchar | 市场 |
| close_price | decimal | 当前价格 |
| enterprise_value | decimal | 企业价值 |
| equity_value | decimal | 股权价值 |
| intrinsic_value_per_share | decimal | 每股内在价值 |
| valuation_gap | decimal | 估值偏离度 |
| wacc | decimal | WACC |
| terminal_growth_rate | decimal | 终端增长率 |
| terminal_value_ratio | decimal | 终端价值占比 |
| data_quality_flag | varchar | 数据质量标记 |
| model_version | varchar | 模型版本 |
| parameter_version | varchar | 参数版本 |
| created_at | datetime | 创建时间 |

## 4. 可追溯设计

每一条估值结果都需要能追溯到：

- 使用的财务数据版本；
- 使用的行情日期；
- 使用的参数版本；
- 使用的模型版本；
- 对应的任务运行日志；
- 是否存在数据质量问题。

## 5. 数据库扩展方向

后续可以新增：

- `valuation_sensitivity`：敏感性分析表；
- `industry_assumption`：行业默认参数表；
- `fx_rate`：汇率表；
- `ah_premium`：A/H 溢价分析表；
- `model_backtest_result`：估值因子回测表。
