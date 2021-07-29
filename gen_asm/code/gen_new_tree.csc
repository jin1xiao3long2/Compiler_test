import check_LR_grammar
import grammar_transfer
import ebnf_parser
import parsergen
import parse_new_grammar
import regex
import ast_visitor

function from_file(path)
    var ifs = iostream.ifstream(path)
    if !ifs.good()
        return
    end
    var input = new string
    while ifs.good()
        var line = ifs.getline()
        input += line + "\n"
        for i = 0, i < line.size, ++i
            if line[i] == '\t'
                line.assign(i, ' ')
            end
        end
    end
    
    return input
end

var parser = new parsergen.generator
var new_tree = new grammar_transfer.traversal_old_tree
#var res = new grammar_transfer.traversal_new_tree
var LR_term_list = new check_LR_grammar.LR_term

var NFA = new check_LR_grammar.NFA_type
var DFA = new check_LR_grammar.DFA_type

var slr_parser = new parse_new_grammar.slr_parser_type

var visitor = new ast_visitor.main

@begin
var cminus_lexical = {
    "ID" : regex.build("^[A-Za-z_]\\w*$"),
    "NUMBER" : regex.build("^[0-9]+\\.?([0-9]+)?$"),
    "STR" : regex.build("^(\"|\"([^\"]|\\\\\")*\"?)$"),
    "CHAR" : regex.build("^(\'|\'([^\']|\\\\(0|\\\\|\'|\"|\\w))\'?)$"),
    "BSIG" : regex.build("^(;|:=?|\\?|\\.\\.?|\\.\\.\\.)$"),
    "MSIG" : regex.build("^(\\+(\\+|=)?|-(-|=|>)?|\\*=?|/=?|%=?|\\^=?)$"),
    "LSIG" : regex.build("^(>|<|&|(\\|)|&&|(\\|\\|)|!|==?|!=?|>=?|<=?)$"),
    "BRAC" : regex.build("^(\\(|\\)|\\[|\\]|\\{|\\}|,)$"),
    "ign" : regex.build("^([ \\f\\r\\t\\v\n]+|#.*)$"),
    "err" : regex.build("^(\"|\'|(\\|)|\\.\\.)$")
}.to_hash_map()
@end

parser.add_grammar("ebnf-lang", ebnf_parser.grammar)

parser.enable_log = false
parser.from_file(context.cmd_args.at(1))

if !parser.ast == null
    #parsergen.print_ast(parser.ast)
    new_tree.run(parser.ast)
    #foreach it in new_tree.store_name do system.out.println(it)
    #system.out.println("\n\n")
    #parsergen.print_header("show list")
    LR_term_list.run(new_tree.res)

    # system.out.println("\n\n")
    # parsergen.print_header("show FIRST SET")
    # LR_term_list.show_first_follow_map(LR_term_list.first_map)

    # system.out.println("\n\n")
    # parsergen.print_header("show FOLLOW SET")
    # LR_term_list.show_first_follow_map(LR_term_list.follow_map)

    # parsergen.print_header("show_mark_info")
    # LR_term_list.show_result()
   
    NFA.run(LR_term_list.result)
    DFA.run(NFA.result_list,LR_term_list.first_map, LR_term_list.follow_map)

    # system.out.println("\n\n")
    # parsergen.print_header("LOG INFO")
    # foreach mes in DFA.log_info do system.out.println(mes)

    # system.out.println("\n\n")
    # parsergen.print_header("ERROR INFO")
    # foreach mes in DFA.error_info do system.out.println(mes)

    #需要分析
    # system.out.println("\n\n")
    # parsergen.print_header("CREATE PREDICT TABLE")
    DFA.create_predict_table()

    # system.out.println("\n\n")
    # parsergen.print_header("SHOW PREDICT TABLE")
    # DFA.show_predict_table()

    # system.out.println("\n\n")
    # parsergen.print_header("PARSING CODE")
    
    var code = from_file(context.cmd_args.at(2))
    slr_parser.run(code, DFA.predict_table, cminus_lexical)
    slr_parser.slr_lex()
    slr_parser.slr_parse()

    system.out.println("\n\n")
    parsergen.print_header("SHOW TREE")
    slr_parser.show_trees(slr_parser.tree_stack.back, 0)

    visitor.run(slr_parser.tree_stack.back)
end