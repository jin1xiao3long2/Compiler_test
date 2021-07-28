import visitorgen
import new_c
var ofs = iostream.ofstream("./new_c_visitor.csp")
(new visitorgen.visitor_generator).run(ofs, new_c.grammar.stx)