# 03 数据流程设计

## 1. 数据流程总览

系统数据流程从股票池配置开始，最终输出 DCF 估值结果。

```text
配置文件读取
   ↓
生成待估值股票池
   ↓
采集基础信息、行情、财务报表和宏观参数
   ↓
原始数据入库
   ↓
字段标准化、币种转换、期间对齐
   ↓
生成清洗后数据表
   ↓
计算历史财务指标
   ↓
生成预测期 FCFF
   ↓
估计 WACC 与终端增长率
   ↓
计算企业价值和股权价值
   ↓
计算每股内在价值和估值偏离度
   ↓
结果质量检查
   ↓
估值结果入库并输出报告
```

## 2. 输入数据

### 2.1 股票基础信息

| 字段 | 含义 |
|---|---|
| stock_code | 股票代码 |
| stock_name | 股票名称 |
| market | 市场：A_SHARE 或 H_SHARE |
| exchange | 交易所 |
| listing_status | 上市状态 |
| industry | 行业分类 |
| currency | 交易币种 |
| is_ah_dual_listed | 是否 A/H 双重上市 |

### 2.2 行情数据

| 字段 | 含义 |
|---|---|
| trade_date | 交易日期 |
| stock_code | 股票代码 |
| close_price | 收盘价 |
| market_cap | 总市值 |
| shares_outstanding | 总股本 |
| turnover | 成交额 |

### 2.3 财务报表数据

| 报表 | 关键字段 |
|---|---|
| 利润表 | revenue、operating_profit、EBIT、tax_expense、net_profit |
| 资产负债表 | cash、short_term_debt、long_term_debt、total_debt、total_equity |
| 现金流量表 | operating_cash_flow、capex、depreciation_amortization |

### 2.4 估值参数

| 参数 | 含义 |
|---|---|
| risk_free_rate | 无风险利率 |
| market_risk_premium | 市场风险溢价 |
| beta | 股票或行业 Beta |
| cost_of_debt | 债务成本 |
| tax_rate | 所得税率 |
| terminal_growth_rate | 终端增长率 |
| forecast_years | 显式预测期 |

## 3. 数据清洗规则

### 3.1 股票代码标准化

A 股：

```text
600000 → 600000.SH
000001 → 000001.SZ
```

H 股：

```text
700 → 0700.HK
9988 → 9988.HK
```

### 3.2 币种统一

DCF 估值需要保证现金流、债务、现金、股价和股本口径一致。

建议规则：

- A 股默认使用人民币；
- H 股默认使用港币；
- 若财务报表币种与交易币种不同，使用期末汇率或平均汇率转换；
- 汇率来源和转换日期需要入库保存。

### 3.3 财务期间对齐

- 年报优先；
- 若年报缺失，可使用 TTM 数据；
- 会计年度不同的公司需要按 fiscal_year 标记；
- 估值日期需匹配当时可获得的最新财务数据，避免未来函数。

### 3.4 缺失值处理

| 数据类型 | 处理方式 |
|---|---|
| 收盘价缺失 | 使用最近一个有效交易日价格 |
| 财务字段缺失 | 不直接填充，标记为缺失并进入异常清单 |
| 行业 Beta 缺失 | 使用市场默认 Beta 或行业中位数 |
| 税率缺失 | 使用法定税率或行业默认值 |
| 股本缺失 | 股票进入不可估值清单 |

### 3.5 异常值检查

需要检查：

- 负收入；
- 极端收入增长率；
- WACC 小于或等于终端增长率；
- 终端价值占企业价值比例过高；
- 每股内在价值为负；
- 估值偏离度超过合理区间；
- 股本为 0 或缺失。

## 4. 输出数据

最终估值结果表应包含：

| 字段 | 含义 |
|---|---|
| valuation_date | 估值日期 |
| stock_code | 股票代码 |
| stock_name | 股票名称 |
| market | 市场 |
| close_price | 当前股价 |
| intrinsic_value_per_share | 每股内在价值 |
| valuation_gap | 估值偏离度 |
| enterprise_value | 企业价值 |
| equity_value | 股权价值 |
| wacc | WACC |
| terminal_growth_rate | 终端增长率 |
| forecast_years | 预测年数 |
| data_quality_flag | 数据质量标记 |
| model_version | 模型版本 |
| parameter_version | 参数版本 |

## 5. 数据流程图

详见：`docs/diagrams/data_flow.mmd`。
