# 分支管理规范

## 1. 主分支

| 分支 | 作用 |
|---|---|
| main | 稳定版本，只保存可提交的最终方案 |
| develop | 日常整合分支，可选 |

## 2. 功能分支命名

```text
feature/module-name
fix/document-error
docs/update-readme
config/update-assumption-template
```

示例：

```text
feature/database-design
feature/dcf-methodology
fix/data-flow-description
```

## 3. 合并规则

- 不直接向 main 分支提交；
- 所有修改通过 Pull Request 合并；
- 合并前至少完成自查；
- 若修改 DCF 核心假设，必须在 PR 中说明原因。
