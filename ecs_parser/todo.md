# ecs前端部分步骤(8.3+)

## 生成正确的predict_table

  保证预测表的正确 ;

## lexer分析

  是否能够保证 { ENDL } 被分析成单个 ENDL ;

## 完整的slr分析(暂不提供报错)

  对ignore语法的处理

## 提供报错信息(涉及lexer部分)

  从lexer分析报错到parser分析报错

## 还原 原语法语法树

  主要为merge, 需要提供merge规则

## 支持后端