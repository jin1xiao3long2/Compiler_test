# Yet other compiler and vm prototype
## Bytecode Standard
VM 采用大端序、32位定长指令
| Mnemonic | Opcode (in hex, 1 byte) | Other bytes ([count]: [operand labels]) | Description |
| ---- | ---- | ---- | ----|
| NONE | 00 | 3 Byte Alignment | 空指令 |
| EROR | 0F | 3 Byte Alignment | 错误 |
| PLBI | 01 | 1 Byte Alignment, 2 Byte Data | 推送32位整数的低位到栈上 |
| PHBI | 02 | 1 Byte Alignment, 2 Byte Data | 推送32位整数的高位到栈上 |
| PLBF | 03 | 1 Byte Alignment, 2 Byte Data | 推送单精度浮点的低位到栈上 |
| PHBF | 04 | 1 Byte Alignment, 2 Byte Data | 推送单精度浮点的高位到栈上 |
| SADD | 10 | 3 Byte Alignment | 计算栈顶两个数的和 |
| IADD | 11 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的和 |
| SSUB | 12 | 3 Byte Alignment | 计算栈顶两个数的差 |
| ISUB | 13 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的差 |
| SMUL | 14 | 3 Byte Alignment | 计算栈顶两个数的积 |
| IMUL | 15 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的积 |
| SDIV | 16 | 3 Byte Alignment | 计算栈顶两个数的商 |
| IDIV | 17 | 1 Byte Alignment, 2 Byte Data | 计算栈顶数与16位整数的商 |
| NJMP | 20 | 1 Byte Alignment, 2 Byte Target PC | 无条件跳转 |
| CJMP | 21 | 1 Byte Alignment, 2 Byte Target PC | 当栈顶数 > 0 时条件跳转 |
| CALL | 22 | 1 Byte Argument Count, 2 Byte Subprogram ID | 长跳转 |
| FEOF | FF | 3 Byte Alignment | 文件结尾 |
