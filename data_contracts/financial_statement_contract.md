# 财务报表数据契约

## 表名

`financial_statement`

## 目的

保存标准化后的利润表、资产负债表和现金流量表关键字段，用于 FCFF 预测和 DCF 估值。

## 字段定义

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| stock_code | string | 是 | 股票代码 |
| report_date | date | 是 | 报告期日期 |
| fiscal_year | integer | 是 | 会计年度 |
| statement_type | string | 是 | annual、quarterly、ttm |
| revenue | decimal | 是 | 营业收入 |
| ebit | decimal | 否 | 息税前利润 |
| tax_expense | decimal | 否 | 所得税费用 |
| depreciation_amortization | decimal | 否 | 折旧摊销 |
| capex | decimal | 否 | 资本开支 |
| operating_cash_flow | decimal | 否 | 经营现金流 |
| cash | decimal | 否 | 现金及现金等价物 |
| total_debt | decimal | 否 | 有息负债 |
| currency | string | 是 | 报表币种 |
| data_source | string | 是 | 数据来源 |

## 校验规则

- `report_date` 不能晚于 `valuation_date`；
- 同一股票、同一报告期、同一报表类型不应重复；
- 若 `revenue` 缺失，则该股票无法进行标准 FCFF 估值；
- 若 `capex` 缺失，可使用经营现金流推导或标记为 WARNING；
- 若财务数据币种与行情币种不同，必须有汇率转换记录。
