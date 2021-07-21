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
        )}
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
|\[...]|可选(0次或1次)|
|{...}|重复(任意次数)|
|(...)|分组|
|"..."|终结符（字符串）|
|'...'|终结符（字符串）|
|\[A-Z]*|终结符（token类型）|
|\[a-z]*|非终结符|
|(\*...\*)|注释|
|?...?|特殊序列(语言描述)|
|_|除外(非)|

是否具有拓展待考察,目前这些暂可支持完整测试集

+ parser,定义语法规则
  + 特殊序列需要去除, 无法解析
  + 非符号(_)解析
  + token(正则表达式)分离出来进行解析 
  + 分组(小括号)需要删去或添加语义


```ebnf

program ::= statement {statement} ;

statement ::= non_terminal_symbol assign_op declaration end_op ;

assign_op ::= '='
            | '::='
            ;

end_op ::= ';'
         | "."
         ;

declaration ::= term {'|' term};

term ::= part {[','] part};

part ::= repeat_part
       | declaration_part
       | alternative_part
       | simple_part
       ;

repeat_part ::= '{' declaration '}' ;

declaration_part ::= '(' declaration ')' ;

alternative_part ::= '[' declaration ']' ;

simple_part ::= right_non_terminal_symbol 
              | terminal_symbol
              ;

right_non_terminal_symbol ::= non_terminal_symbol ;

terminal_symlol ::= LIT
                  | TOKEN
                  ;


non_terminal_symbol ::= ID ;

characters ::= ?all character that can be seen?

(*find a way to describe it*)

(* about token *)

```

+ 翻译方案

```python

internal :  record the internal  
# begin ::= statement {statement}


output("@begin")
output("var test_syntax = {")
if(!stmts.empty)
    foreach iter in stmts
        trans_statement(internal, iter)
        if(iter.next)
            output(",")
        end
    end
end
output("}.to_hash_map()")
output("@end")


# statement ::= non_terminal_symbol assign_op declaration end_op

output("\"")
trans_non_terminal_symbol(0, nt_symbol) #print literal
output("\" : {\n")
trans_declaration(internal, decl)
output("}")

#declaration ::= term {[endline] '|' term};

if terms.size > 1
    output("syntax.cond_or(\n")
    foreach iter in terms
        output("{")
        trans_term(internal, iter)
        output("}")
        if(iter.next)
            output(",")
        end
        output("\n")
    end
    output(")")
else
    trans_term(term[0])
end

#part ::= repeat_part
#       | declaration_part
#       | alternative_part
#       | simple_part
#       ;

switch(peek())
    case '{'
        parse_repeat_part(internal, part)
    end
    case '['
        parse_alternative_part(internal, part)
    end
    case '('
        parse_declaration_part(internal, part)
    end
    default
        parse_simple_part(internal, part)
    end
end

# repeat_part ::= '{' declaration '}' ;
output("syntax.repeat(")
parse_declaration(internal, declaration)
output(")")

# declaration_part ::= '(' declaration ')' ;
output("syntax.ref(")
parse_declaration(internal, declaration)
output(")")

# alternative_part ::= '[' declaration ']' ;
output("syntax.optional(")
parse_declaration(internal, declaration)
output(")")

# simple_part ::= non_terminal_symbol 
#              | terminal_symbol
#              ;

if(peek() == '\'' || peek() == '"' || !is_upper(peek()))
parse_terminal_symbol()
else if(is_upper(peek()))
parse_non_terminal()
end

#terminal_symlol ::= '\'' characters '\''
#                  | '\"' characters '\"'
#                  | token
#                  ;

if(token)
output("syntax.token(" + token.data.down() +")")
else
output("syntax.term(" + characters + ")")
end

#non_terminal_symbol ::= identifier ;

output("syntax.ref(" + identifier + ")")


```

