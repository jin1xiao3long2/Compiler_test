# Yet other compiler and vm prototype
## Bytecode Standard
VM 采用大端序、32位定长指令
| Mnemonic | Opcode (in hex) | Other bytes ([count]: [operand labels]) | Description |
| ---- | ---- | ---- | ----|
| NONE | 00 | 3-32:Alignment | 空指令 |
| PINT | 01 | 3-32:Data | 推送一个32位立即数到栈上 |
| PFLT | 10 | 3-32:Data | 推送一个双精度浮点数到栈上 |
| CADD | 11 | 3-32:Alignment | 计算栈顶两个数的和 |
| CSUB | 12 | 3-32:Alignment | 计算栈顶两个数的差 |
| CMUL | 13 | 3-32:Alignment | 计算栈顶两个数的积 |
| CDIV | 14 | 3-32:Alignment | 计算栈顶两个数的商 |
| NJMP | 20 | 3-32:Target PC | 无条件跳转 |
| CJMP | 21 | 3-32:Target PC | 当栈顶数 > 0 时条件跳转 |
| CALL | 22 | 3-16:Argument Count, 17-32: Subprogram ID | 长跳转 |
| FEOF | FF | 3-32:FF | 文件结尾 |
