import check_LR_grammar
import grammar_transfer
import ebnf_parser
import parsergen
import parse_new_grammar
import regex

var parser = new parsergen.generator
var new_tree = new grammar_transfer.traversal_old_tree
#var res = new grammar_transfer.traversal_new_tree
var LR_term_list = new check_LR_grammar.LR_term

var NFA = new check_LR_grammar.NFA_type
var DFA = new check_LR_grammar.DFA_type

var slr_parser = new parse_new_grammar.slr_parser_type

@begin
var ebnf_lexical = {
    "ID" : regex.build("^[a-z_]*$"),
    "TOKEN" : regex.build("^[A-Z]*$"),
    "BRAC" : regex.build("^(\\(|\\)|\\[|\\]|\\{|\\})$"),
    "SIG" : regex.build("^(:|::|(::)?=||\\||;)$"),
    "SLIT" : regex.build("^(\'|\'([^\']|\\\\\')*\'?)$"),
    "DLIT" : regex.build("^(\"|\"([^\"]|\\\\\")*\"?)$"),
    "ign" : regex.build("^([ \\f\\r\\t\\v\\n]+)$"),
    "err" : regex.build("^(\"|\'|\\.\\.)$")
}.to_hash_map()
@end


parser.add_grammar("ebnf-lang", ebnf_parser.grammar)

var time_start = runtime.time()
parser.enable_log = false
parser.from_file(context.cmd_args.at(1))
system.out.println("Compile Time: " + (runtime.time() - time_start)/1000 + "s")

if !parser.ast == null
    parsergen.print_ast(parser.ast)
    new_tree.run(parser.ast)
    #foreach it in new_tree.store_name do system.out.println(it)
    system.out.println("\n\n")
    parsergen.print_header("show list")
    LR_term_list.run(new_tree.res)

    system.out.println("\n\n")
    parsergen.print_header("show FIRST SET")
    LR_term_list.show_first_follow_map(LR_term_list.first_map)

    system.out.println("\n\n")
    parsergen.print_header("show FOLLOW SET")
    LR_term_list.show_first_follow_map(LR_term_list.follow_map)

    parsergen.print_header("show_mark_info")
    LR_term_list.show_result()
   
    NFA.run(LR_term_list.result)
    DFA.run(NFA.result_list,LR_term_list.first_map, LR_term_list.follow_map)

    system.out.println("\n\n")
    parsergen.print_header("LOG INFO")
    foreach mes in DFA.log_info do system.out.println(mes)

    system.out.println("\n\n")
    parsergen.print_header("ERROR INFO")
    foreach mes in DFA.error_info do system.out.println(mes)

    #需要分析
    system.out.println("\n\n")
    parsergen.print_header("CREATE PREDICT TABLE")
    DFA.create_predict_table()

    system.out.println("\n\n")
    parsergen.print_header("SHOW PREDICT TABLE")
    DFA.show_predict_table()

    # system.out.println("\n\n")
    # parsergen.print_header("PARSING CODE")
    # slr_parser.run("s ::= '(' s ')'s | NULL;", DFA.predict_table, ebnf_lexical)
    # slr_parser.slr_lex()
    # slr_parser.slr_parse()

    # system.out.println("\n\n")
    # parsergen.print_header("SHOW TREE")
    # slr_parser.show_trees(slr_parser.tree_stack.back, 0)
end