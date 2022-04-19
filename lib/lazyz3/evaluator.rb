require 'pycall'

module LazyZ3
  class Evaluator
    attr_reader :model
    @@z3 = PyCall.import_module("z3")

    def solve(expr)
      solver = @@z3.Solver.new
      @typemap = {}
      z3_expr = eval(expr, {})
      solver.add(z3_expr)
      result = (solver.check == @@z3.sat)
      if result
        @model = {}
        solver.model.decls.each { |d|
          if @typemap[d.to_s] == :int
            @model[d.to_s] = solver.model[d].as_long
          elsif @typemap[d.to_s] == :bool
            @model[d.to_s] = solver.model[d]
          else
            raise LazyZ3::Error, "unknown sort in model #{d.to_s}"
          end
        }
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
            var = @@z3.Int(var_name)
            @typemap[var_name] = :int
            env[var_name] = var
            var
          end
        when :var_bool
          var_name = expr.children[0].to_s
          if env.key? var_name
            env[var_name]
          else
            var = @@z3.Bool(var_name)
            @typemap[var_name] = :bool
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
            @@z3.And(eval(expr.children[1], env), eval(expr.children[2], env))
          when :|
            @@z3.Or(eval(expr.children[1], env), eval(expr.children[2], env))
          when :!
            @@z3.Not(eval(expr.children[1], env))
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

