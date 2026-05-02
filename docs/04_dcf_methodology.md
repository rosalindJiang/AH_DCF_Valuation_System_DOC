# 04 DCF 估值方法说明

## 1. DCF 模型选择

本系统采用 FCFF（Free Cash Flow to Firm，公司自由现金流）模型作为核心估值框架。FCFF 模型适用于不同资本结构的公司，能够从企业整体价值出发，再扣除净债务得到股权价值。

## 2. 核心计算公式

### 2.1 公司自由现金流

```text
FCFF = EBIT × (1 - Tax Rate) + Depreciation & Amortization - Capital Expenditure - ΔNet Working Capital
```

其中：

- `EBIT`：息税前利润；
- `Tax Rate`：有效税率或标准税率；
- `Depreciation & Amortization`：折旧摊销；
- `Capital Expenditure`：资本开支；
- `ΔNet Working Capital`：净营运资本变动。

### 2.2 企业价值

```text
Enterprise Value = Σ FCFF_t / (1 + WACC)^t + Terminal Value / (1 + WACC)^n
```

### 2.3 终端价值

```text
Terminal Value = FCFF_n × (1 + g) / (WACC - g)
```

其中：

- `g`：终端增长率；
- `WACC` 必须大于 `g`，否则模型无效。

### 2.4 股权价值

```text
Equity Value = Enterprise Value - Total Debt + Cash and Cash Equivalents + Other Adjustments
```

### 2.5 每股内在价值

```text
Intrinsic Value per Share = Equity Value / Shares Outstanding
```

### 2.6 估值偏离度

```text
Valuation Gap = Intrinsic Value per Share / Market Price - 1
```

若 `Valuation Gap > 0`，表示模型估计内在价值高于当前市场价格；若小于 0，则表示当前市场价格高于模型估计内在价值。

## 3. WACC 计算方法

WACC 是加权平均资本成本，用于折现未来公司自由现金流。

```text
WACC = E / (D + E) × Cost of Equity + D / (D + E) × Cost of Debt × (1 - Tax Rate)
```

其中：

- `E`：股权市值；
- `D`：有息债务；
- `Cost of Equity`：权益资本成本；
- `Cost of Debt`：债务资本成本；
- `Tax Rate`：所得税率。

### 3.1 权益资本成本

采用 CAPM：

```text
Cost of Equity = Risk Free Rate + Beta × Market Risk Premium
```

参数说明：

| 参数 | 说明 |
|---|---|
| Risk Free Rate | 无风险利率，A 股可参考中国国债收益率，H 股可参考香港政府债券或美元利率体系 |
| Beta | 个股 Beta 或行业 Beta |
| Market Risk Premium | 市场风险溢价，可使用内部研究假设 |

### 3.2 债务资本成本

可采用以下优先级：

1. 公司实际利息支出 / 平均有息负债；
2. 公司债券收益率；
3. 行业平均债务成本；
4. 市场默认债务成本。

## 4. 终端增长率设计

终端增长率反映企业在长期稳定阶段的增长水平。

建议约束：

- 终端增长率应低于 WACC；
- 终端增长率不应长期高于宏观经济名义增速；
- 成熟行业使用较低终端增长率；
- 高成长行业可使用相对较高但仍保守的终端增长率；
- 若 `WACC - g` 过小，应触发质量检查。

## 5. 显式预测期设计

系统默认显式预测期为 5 年，也可配置为 3、5、10 年。

| 公司类型 | 建议预测期 |
|---|---:|
| 成熟稳定公司 | 5 年 |
| 高成长公司 | 10 年 |
| 周期性公司 | 5 年并进行情景分析 |
| 金融类公司 | 建议采用专门估值模型，不优先使用标准 FCFF |

## 6. 财务预测逻辑

### 6.1 收入预测

可选方法：

- 历史 3 年 CAGR；
- 历史 5 年 CAGR；
- 行业增长率；
- 分阶段增长率；
- 人工配置增长率。

### 6.2 EBIT Margin 预测

可采用：

- 历史均值；
- 最近一年水平；
- 行业中位数；
- 向长期稳定利润率收敛。

### 6.3 折旧摊销、资本开支和营运资本

常用假设：

```text
Depreciation & Amortization = Revenue × Historical D&A / Revenue Ratio
Capital Expenditure = Revenue × Historical Capex / Revenue Ratio
ΔNet Working Capital = Revenue Change × NWC / Revenue Ratio
```

## 7. 情景分析

系统建议支持三种情景：

| 情景 | 假设特点 |
|---|---|
| 保守情景 | 较低收入增长率、较高 WACC、较低终端增长率 |
| 中性情景 | 使用默认参数 |
| 乐观情景 | 较高收入增长率、较低 WACC、较高终端增长率 |

最终结果可输出三类内在价值，或以中性情景作为主结果。

## 8. 敏感性分析

建议对以下参数进行敏感性分析：

- WACC；
- 终端增长率；
- 收入增长率；
- EBIT Margin；
- 资本开支率。

敏感性分析可以帮助识别估值结果对核心假设的依赖程度。

## 9. 不适用或需特殊处理的公司

以下公司需单独标记：

- 金融、银行、保险类公司；
- 最近几年自由现金流长期为负的公司；
- 财务数据严重缺失的公司；
- 刚上市、历史数据不足的公司；
- 处于重大重组或退市风险状态的公司。

这些公司可以进入“暂不估值”或“特殊模型估值”清单。
