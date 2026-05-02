# 示例估值结果表

以下表格为输出格式示例，不代表真实估值结果。

| valuation_date | stock_code | stock_name | market | close_price | intrinsic_value_per_share | valuation_gap | wacc | terminal_growth_rate | data_quality_flag |
|---|---|---|---|---:|---:|---:|---:|---:|---|
| 2025-12-31 | 600519.SH | 贵州茅台 | A_SHARE | 1600.00 | 1750.00 | 0.0938 | 0.082 | 0.025 | PASS |
| 2025-12-31 | 0700.HK | 腾讯控股 | H_SHARE | 380.00 | 420.00 | 0.1053 | 0.090 | 0.020 | PASS |
| 2025-12-31 | 9988.HK | 阿里巴巴-W | H_SHARE | 75.00 | 82.00 | 0.0933 | 0.095 | 0.020 | WARNING |
| 2025-12-31 | 600000.SH | 浦发银行 | A_SHARE | 8.00 | N/A | N/A | N/A | N/A | SPECIAL_MODEL_REQUIRED |

## 字段解释

| 字段 | 说明 |
|---|---|
| valuation_date | 估值日期 |
| stock_code | 股票代码 |
| close_price | 当前价格 |
| intrinsic_value_per_share | DCF 模型计算的每股内在价值 |
| valuation_gap | 内在价值相对当前价格的偏离度 |
| wacc | 加权平均资本成本 |
| terminal_growth_rate | 终端增长率 |
| data_quality_flag | 数据质量与模型有效性标记 |
