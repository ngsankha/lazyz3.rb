require 'z3'

module LazyZ3
  class Evaluator
    attr_reader :model

    def solve(expr)
      solver = Z3::Solver.new
      z3_expr = eval(expr, {})
      solver.assert(z3_expr)
      result = solver.satisfiable?
      if result
        @model = solver.model
      end
      result
    end

    private
    def eval(expr, env)
      if expr.is_a?(Integer) || expr.bool?
        expr
      elsif expr.is_a? Z3Node
        case expr.type
        when :const
          expr.children[0]
        when :var_int
          var_name = expr.children[0].to_s
          if env.key? var_name
            env[var_name]
          else
            var = Z3.Int(var_name)
            env[var_name] = var
            var
          end
        when :var_bool
          if env.key? var_name
            env[var_name]
          else
            var = Z3.Bool(var_name)
            env[var_name] = var
            var
          end
        when :send
          case expr.children[0]
          when :+
            eval(expr.children[1], env) + eval(expr.children[2], env)
          when :-
            eval(expr.children[1], env) - eval(expr.children[2], env)
          when :*
            eval(expr.children[1], env) * eval(expr.children[2], env)
          when :/
            eval(expr.children[1], env) / eval(expr.children[2], env)
          when :==
            eval(expr.children[1], env) == eval(expr.children[2], env)
          when :!=
            eval(expr.children[1], env) != eval(expr.children[2], env)
          when :<
            eval(expr.children[1], env) < eval(expr.children[2], env)
          when :>
            eval(expr.children[1], env) > eval(expr.children[2], env)
          when :<=
            eval(expr.children[1], env) <= eval(expr.children[2], env)
          when :>=
            eval(expr.children[1], env) >= eval(expr.children[2], env)
          when :&
            eval(expr.children[1], env) & eval(expr.children[2], env)
          when :|
            eval(expr.children[1], env) | eval(expr.children[2], env)
          when :!
            !eval(expr.children[1], env)
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

