import grammar_transfer
import ebnf_parser
import parsergen

var parser = new parsergen.generator
var new_tree = new grammar_transfer.traversal_old_tree
var res = new grammar_transfer.traversal_new_tree
parser.add_grammar("ebnf-lang", ebnf_parser.grammar)

var time_start = runtime.time()
parser.enable_log = true
parser.from_file(context.cmd_args.at(1))
system.out.println("Compile Time: " + (runtime.time() - time_start)/1000 + "s")

if !parser.ast == null
    parsergen.print_ast(parser.ast)
    new_tree.run(parser.ast)
    #foreach it in new_tree.store_name do system.out.println(it)
    res.run(system.out, new_tree.root)
end