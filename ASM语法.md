# VM 汇编语法

## 概念
- 段：整个 rvm 程序由若干段构成
- 指令：段由若干指令构成
- 域：针对段的概念，每个**代码段**被视为一个域，调用时的**非本身段**被视为进入子域
- 域结构：每个域由一个**数据栈**构成

## 段
- 数据段
    - 数据：由变量名和字节长度构成 格式：[id]:[number] 如：var1:4
- 代码段
    - 主函数：程序入口，会主动执行一次 格式：[instruction]* 如 PI 1024:i PI 1000:i SADD
    - 子程序：由指令组成，不会主动执行 格式：同上

| 关键字 | 描述 |
|---|---|
| DATA | 数据段开始 |
| ENDDATA | 数据段结束 |
| CODE | 代码段开始 |
| ENDCODE | 代码段结束 |
| SUBP | 子程序段开始 |
| SUBPEND | 子程序段结束 |

## 指令
所有运算指令的结果均保存在当前域下数据栈顶

| 指令 | 描述 | 示例 |
|---|---|---|
| MOV | 数据拷贝，仅适用于目标长度大于等于源长度 | MOV var1 20:i |
| PI | 向当前域下数据栈 push 32 位 integer 数据 | PI 1024:f |
| PF | 向当前域下数据栈 push 32 位 float 数据 | PF 1.024:f |
| PDAT | *不晓得 | ?? |
| SADD/SSUB/SMUL/SDIV | 将当前域下数据栈顶两个数据做 integer 四则运算 | SADD |
| IADD/ISUB/IMUL/IDIV | 将当前域下数据栈顶和一个立即数数做 integer 四则运算 | IADD 12 |
| DADD/DSUB/DMUL/DDIV | 将数据段内两个数据做 integer 四则运算 | DADD var1 var2 |
| FLAG | 标记代码行数 | FLAG f1 |
| NJMP | 无条件跳转至标记处 | NJMP f1 |
| CJMP | 当前域下数据栈顶为正则跳转至标记处 | CJMP f1 |
| CALL | 调用（跳转至标记处或子程序处） | CALL func |
| RETP | 返回调用处（跳转至调用者的下一行） | RETP |
