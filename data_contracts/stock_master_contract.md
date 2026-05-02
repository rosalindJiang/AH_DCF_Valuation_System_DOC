# 股票基础信息数据契约

## 表名

`stock_master`

## 目的

保存 A 股和 H 股股票的统一基础信息，是行情、财务和估值结果关联的主表。

## 字段定义

| 字段 | 类型 | 必填 | 说明 | 示例 |
|---|---|---|---|---|
| stock_code | string | 是 | 标准化股票代码 | 600519.SH |
| stock_name | string | 是 | 股票名称 | 贵州茅台 |
| market | string | 是 | 市场类型 | A_SHARE |
| exchange | string | 是 | 交易所 | SSE |
| industry | string | 否 | 行业分类 | Food & Beverage |
| currency | string | 是 | 交易币种 | CNY |
| listing_status | string | 是 | 上市状态 | listed |
| is_ah_dual_listed | boolean | 是 | 是否 A/H 双重上市 | false |
| update_time | datetime | 是 | 更新时间 | 2025-12-31 18:00:00 |

## 校验规则

- `stock_code` 不能为空；
- `market` 只能为 `A_SHARE` 或 `H_SHARE`；
- `currency` 应与市场匹配，A 股通常为 CNY，H 股通常为 HKD；
- 退市股票默认不进入估值股票池，除非配置允许。
