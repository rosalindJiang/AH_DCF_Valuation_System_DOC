# 行情数据契约

## 表名

`market_daily`

## 目的

保存股票日度行情与市值数据，用于估值日期价格、股本和市场权重计算。

## 字段定义

| 字段 | 类型 | 必填 | 说明 |
|---|---|---|---|
| trade_date | date | 是 | 交易日期 |
| stock_code | string | 是 | 股票代码 |
| close_price | decimal | 是 | 收盘价 |
| market_cap | decimal | 否 | 总市值 |
| shares_outstanding | decimal | 是 | 总股本 |
| turnover | decimal | 否 | 成交额 |
| currency | string | 是 | 行情币种 |
| data_source | string | 是 | 数据来源 |

## 校验规则

- `close_price` 必须大于 0；
- `shares_outstanding` 必须大于 0；
- 若估值日期不是交易日，使用最近一个有效交易日；
- 若 `market_cap` 与 `close_price × shares_outstanding` 差异过大，应触发 WARNING。
