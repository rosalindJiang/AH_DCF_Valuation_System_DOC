# 估值结果数据契约

## 表名

`valuation_result`

## 目的

保存 DCF 估值最终输出结果，供查询、排序、报告和下游策略使用。

## 字段定义

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| valuation_date | date | 是 | 估值日期 |
| stock_code | string | 是 | 股票代码 |
| market | string | 是 | 市场 |
| close_price | decimal | 是 | 当前市场价格 |
| enterprise_value | decimal | 否 | 企业价值 |
| equity_value | decimal | 否 | 股权价值 |
| intrinsic_value_per_share | decimal | 否 | 每股内在价值 |
| valuation_gap | decimal | 否 | 估值偏离度 |
| wacc | decimal | 否 | 加权平均资本成本 |
| terminal_growth_rate | decimal | 否 | 终端增长率 |
| terminal_value_ratio | decimal | 否 | 终端价值占企业价值比例 |
| data_quality_flag | string | 是 | PASS、WARNING、FAIL、SPECIAL_MODEL_REQUIRED |
| model_version | string | 是 | 模型版本 |
| parameter_version | string | 是 | 参数版本 |
| created_at | datetime | 是 | 创建时间 |

## 校验规则

- `wacc` 必须大于 `terminal_growth_rate`；
- `close_price` 必须大于 0；
- 若 `intrinsic_value_per_share` 缺失，必须说明失败原因；
- `data_quality_flag` 必须有明确取值；
- 同一股票、同一估值日期、同一模型版本和参数版本不应重复。
