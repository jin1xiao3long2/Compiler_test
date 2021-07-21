import visitorgen, ebnf_parser
var ofs = iostream.ofstream("./ast_visitor.csp")
(new visitorgen.visitor_generator).run(ofs, ebnf_parser.grammar.stx)