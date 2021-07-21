import ebnf_ast_visitor
import ebnf_parser
import parsergen

var parser = new parsergen.generator
var visitor = new ebnf_ast_visitor.main
parser.add_grammar("ebnf-lang", ebnf_parser.grammar)

var time_start = runtime.time()
parser.enable_log = false
parser.from_file(context.cmd_args.at(1))
system.out.println("Compile Time: " + (runtime.time() - time_start)/1000 + "s")



if parser.ast != null
    #parsergen.print_ast(parser.ast)
    visitor.run(system.out, parser.ast)
end