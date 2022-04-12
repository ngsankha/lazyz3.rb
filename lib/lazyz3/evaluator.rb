require 'z3'

module LazyZ3
  class Evaluator
    def solve(expr)
      solver = Z3::Solver.new
      solver.assert(eval(expr))
      result = solver.satisfiable?
      if result
        @model = solver.model
      end
      result
    end

    private
    def eval(expr)
      if expr.is_a?(Integer) || expr.bool?
        expr
      elsif expr.is_a? Z3Node
        case expr.type
        when :const
          expr.children[0]
        when :var_int
          Z3.Int(expr.children[0].to_s)
        when :var_bool
          Z3.Bool(expr.children[0].to_s)
        when :send
          case expr.children[0]
          when :+
            eval(expr.children[1]) + eval(expr.children[2])
          when :-
            eval(expr.children[1]) - eval(expr.children[2])
          when :*
            eval(expr.children[1]) * eval(expr.children[2])
          when :/
            eval(expr.children[1]) / eval(expr.children[2])
          when :==
            eval(expr.children[1]) == eval(expr.children[2])
          when :!=
            eval(expr.children[1]) != eval(expr.children[2])
          when :<
            eval(expr.children[1]) < eval(expr.children[2])
          when :>
            eval(expr.children[1]) > eval(expr.children[2])
          when :<=
            eval(expr.children[1]) <= eval(expr.children[2])
          when :>=
            eval(expr.children[1]) >= eval(expr.children[2])
          when :&
            eval(expr.children[1]) & eval(expr.children[2])
          when :|
            eval(expr.children[1]) | eval(expr.children[2])
          when :!
            !eval(expr.children[1])
          else
            raise LazyZ3::Error, "no known mapping to Z3 for #{expr.children[1]}"
          end
        else
          raise LazyZ3::Error, "unexpected node type"
        end
      else
        raise LazyZ3::Error, "unexpected type"
      end
    end
  end

  def self.solve(expr)
    e = Evaluator.new
    e.solve(expr)
  end
end

