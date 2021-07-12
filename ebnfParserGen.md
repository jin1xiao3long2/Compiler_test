# From EBNF to Lexer & Parser


## Input:

```ebnf

program ::= declaration {declaration};

declaration ::= type_specifier ID declaration_s

declaration_s ::= ';' 
                | '[' NUM ']' ';'
                | '(' params ')' compound_stmt
                ;

...

```




## Output:

```python
@begin
var covscript_syntax = {
    # Beginning of Parsing
    "program" : {
        syntax.ref("declaration"), syntax.repeat("declaration")
    },
    "declaration" : {
        syntax.ref("type_specifier"), syntax.token("ID"), syntax.ref("declaration_s")
    },
    "declaration_s" : {
        syntax.cond_or(
            {syntax.term(";")},
            {syntax.term("["), syntax.token("num"), syntax.term("]"), syntax.token(";")},
            {syntax.term("("), syntax.ref("params"), syntax.term(")"), syntax.ref("compound_stmt")}
    }
}.to_hash_map()
@end

```


包括以下步骤:

+ lexer,定义词法规则,具体表格如下:

|记号|意义|
|:----|:----|
|::=|定义|
|=|定义|
|,|连接符|
| (空格)|连接符|
|;|结束符|
|\||或|
|[...]|可选(0次或1次)|
|{...}|重复(任意次数)|
|(...)|分组|
|"..."|终端字符串|
|'...'|终端字符串|
|(\*...\*)|注释|
|?...?|特殊序列(语言描述)|
|_|除外(非)|

是否具有拓展待考察,目前这些暂可支持完整测试集

+ parser,定义语法规则

待补充