# Yet other compiler and vm prototype
## Bytecode Standard
VM 采用大端序、32位定长指令
| Mnemonic | Opcode (in hex, 1 byte) | Other bytes ([count]: [operand labels]) | Description |
| ---- | ---- | ---- | ----|
| NONE | 00 | 3 Byte Alignment | 空指令 |
| PINT | 01 | 2 Byte Data, 1 Byte Alignment | 推送一个16位立即数到栈上 |
| PFLT | 10 | 2 Byte Data, 1 Byte Alignment | 推送一个单精度浮点数到栈上 |
| CADD | 11 | 3 Byte Alignment | 计算栈顶两个数的和 |
| CSUB | 12 | 3 Byte Alignment | 计算栈顶两个数的差 |
| CMUL | 13 | 3 Byte Alignment | 计算栈顶两个数的积 |
| CDIV | 14 | 3 Byte Alignment | 计算栈顶两个数的商 |
| NJMP | 20 | 2 Byte Target PC, 1 Byte Alignment | 无条件跳转 |
| CJMP | 21 | 2 Byte Target PC, 1 Byte Alignment | 当栈顶数 > 0 时条件跳转 |
| CALL | 22 | 1 Byte Argument Count, 2 Byte Subprogram ID | 长跳转 |
| FEOF | FF | 3 Byte Alignment | 文件结尾 |
