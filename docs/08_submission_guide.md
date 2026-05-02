# 08 GitHub / Gitee 提交说明

## 1. 仓库命名建议

建议仓库名称：

```text
AH_DCF_Valuation_System_Design
```

或：

```text
full_market_ah_dcf_design
```

## 2. 提交内容说明

本仓库提交内容为系统设计方案，不包含具体业务代码实现。提交内容包括：

- 完整 README；
- 业务需求文档；
- 系统架构文档；
- 数据流程文档；
- DCF 方法说明；
- 数据库设计；
- 批量调度设计；
- 风险控制与结果校验；
- 数据契约；
- 配置模板；
- 协作规范；
- Issue 与 PR 模板。

## 3. 推荐提交步骤

```text
1. 新建 GitHub 或 Gitee 仓库
2. 上传整个 AH_DCF_Valuation_System 文件夹内容
3. 检查 README.md 是否能在网页端正常显示
4. 检查 docs 文件夹下所有 Markdown 文件是否可打开
5. 在仓库描述中写明：全市场 AH 股 DCF 估值计算系统设计方案
6. 提交最终链接
```

## 4. 推荐仓库简介

```text
A system design proposal for a full-market A-share and H-share DCF valuation platform, covering architecture, data flow, DCF methodology, database schema, batch scheduling, validation, and collaboration standards.
```

中文简介：

```text
全市场 AH 股 DCF 估值计算系统设计方案，包含系统架构、数据流程、DCF 方法、数据库设计、批量调度、结果校验和协作规范。
```

## 5. 提交前检查清单

- [ ] README 能完整说明项目目标和结构；
- [ ] 架构设计清晰，模块边界明确；
- [ ] 数据流程覆盖采集、清洗、估值、入库和输出；
- [ ] DCF 公式、WACC 和终端增长率解释完整；
- [ ] 数据库表设计合理；
- [ ] 协作规范完整；
- [ ] 文件命名统一；
- [ ] 无敏感个人信息；
- [ ] 明确说明不包含具体代码实现。
