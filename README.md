# Yet other compiler and vm prototype
## Bytecode Standard
VM 采用大端序、32位定长指令
| Mnemonic | Opcode (in hex, 1 byte) | Other bytes ([count]: [operand labels]) | Description |
| ---- | ---- | ---- | ----|
| BEGN | DE | ADFACE | 文件标识起点 |
| DATA | F0 | 3 Byte Alignment | 数据区 |
| SUBP | F1 | 1 Byte Alignment, 2 Byte Subprogram ID | 子程序 |
| NONE | 00 | 3 Byte Alignment | 空指令 |
| PLBI | 01 | 1 Byte Alignment, 2 Byte Data | 推送32位整数的低位到栈上 |
| PHBI | 02 | 1 Byte Alignment, 2 Byte Data | 推送32位整数的高位到栈上 |
| PLBF | 03 | 1 Byte Alignment, 2 Byte Data | 推送单精度浮点的低位到栈上 |
| PHBF | 04 | 1 Byte Alignment, 2 Byte Data | 推送单精度浮点的高位到栈上 |
| PDAT | 05 | 1 Byte Alignment, 2 Byte Addr | 推送数据段数据到栈上 |
| SADD | 10 | 3 Byte Alignment | 计算栈顶两个数的和 |
| IADD | 11 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的和 |
| DADD | 12 | 1 Byte Alignment, 2 Byte Addr | 计算栈顶数与数据段数据的和 |
| SSUB | 13 | 3 Byte Alignment | 计算栈顶两个数的差 |
| ISUB | 14 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的差 |
| DSUB | 15 | 1 Byte Alignment, 2 Byte Addr | 计算栈顶数与数据段数据的差 |
| SMUL | 16 | 3 Byte Alignment | 计算栈顶两个数的积 |
| IMUL | 17 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的积 |
| DMUL | 18 | 1 Byte Alignment, 2 Byte Addr | 计算栈顶数与数据段数据的积 |
| SDIV | 19 | 3 Byte Alignment | 计算栈顶两个数的商 |
| IDIV | 1A | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的商 |
| DDIV | 1B | 1 Byte Alignment, 2 Byte Addr | 计算栈顶数与数据段数据的商 |
| NJMP | 20 | 1 Byte Alignment, 2 Byte Target PC | 无条件跳转 |
| CJMP | 21 | 1 Byte Alignment, 2 Byte Target PC | 当栈顶数 > 0 时条件跳转 |
| CALL | 22 | 1 Byte Argument Count, 2 Byte Subprogram ID | 长跳转，开始子程序调用 |
| RETP | 23 | 3 Byte Alignment | 长跳转，返回子程序调用 |
| FEOF | FF | 3 Byte Alignment | 文件结尾 |
