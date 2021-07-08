# Yet other compiler and vm prototype
## Bytecode Standard
VM 采用大端序、32位定长指令
| Mnemonic | Opcode (in hex, 1 byte) | Other bytes ([count]: [operand labels]) | Description |
| ---- | ---- | ---- | ----|
| NONE | 00 | 3 Byte Alignment | 空指令 |
| PINT | 01 | 2 Byte Data, 1 Byte Alignment | 推送16位整数到栈上 |
| PLBI | 02 | 2 Byte Data, 1 Byte Alignment | 推送32位整数的低位到栈上 |
| PHBI | 03 | 2 Byte Data, 1 Byte Alignment | 推送32位整数的高位到栈上 |
| PLBF | 05 | 2 Byte Data, 1 Byte Alignment | 推送双精度浮点的低位到栈上 |
| PHBF | 06 | 2 Byte Data, 1 Byte Alignment | 推送双精度浮点的高位到栈上 |
| SADD | 10 | 3 Byte Alignment | 计算栈顶两个数的和 |
| IADD | 11 | 2 Byte Data, 1 Byte Alignment | 计算栈顶数与16位整数的和 |
| SSUB | 13 | 3 Byte Alignment | 计算栈顶两个数的差 |
| ISUB | 14 | 2 Byte Data, 1 Byte Alignment | 计算栈顶数与16位整数的差 |
| SMUL | 16 | 3 Byte Alignment | 计算栈顶两个数的积 |
| IMUL | 17 | 2 Byte Data, 1 Byte Alignment | 计算栈顶数与16位整数的积 |
| SDIV | 19 | 3 Byte Alignment | 计算栈顶两个数的商 |
| IDIV | 1A | 2 Byte Data, 1 Byte Alignment | 计算栈顶数与16位整数的商 |
| NJMP | 20 | 2 Byte Target PC, 1 Byte Alignment | 无条件跳转 |
| CJMP | 21 | 2 Byte Target PC, 1 Byte Alignment | 当栈顶数 > 0 时条件跳转 |
| CALL | 22 | 1 Byte Argument Count, 2 Byte Subprogram ID | 长跳转 |
| FEOF | FF | 3 Byte Alignment | 文件结尾 |
