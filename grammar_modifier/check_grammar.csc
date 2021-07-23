import check_LR_grammar
import grammar_transfer
import ebnf_parser
import parsergen

var parser = new parsergen.generator
var new_tree = new grammar_transfer.traversal_old_tree
#var res = new grammar_transfer.traversal_new_tree
var LR_term_list = new check_LR_grammar.LR_term

var NFA = new check_LR_grammar.NFA_type
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
    #res.run(system.out, new_tree.root)
    NFA.run(LR_term_list.result)
end