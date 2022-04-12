# frozen_string_literal: true

require "test_helper"

# module Z3IntegerRefinement
#   refine Integer do
#     prepend LazyZ3::Int
#   end
# end

# using Z3IntegerRefinement

Integer.prepend LazyZ3::Int
TrueClass.prepend LazyZ3::Bool
FalseClass.prepend LazyZ3::Bool

class LazyZ3::LazyZ3Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LazyZ3::VERSION
  end

  def test_integers_behave_correctly
    assert_equal 5 + 3, 8
    assert_equal 5 - 3, 2
    assert_equal 5 * 3, 15
    assert_equal 5 / 3, 1
    assert 5 == 5
    assert 7 != 6
    assert 4 < 7
    assert 6 > 2
    assert 5 <= 5
    assert 3 <= 5
    assert 5 >= 5
    assert 5 >= 3
  end

  def test_booleans_behave_correctly
    assert true == true
    assert false == false
    assert true != false
    assert false != true
  end

  def test_bool_var
    assert_equal LazyZ3::var_bool(:x), s(:var_bool, :x)
  end

  def test_int_var
    assert_equal LazyZ3::var_int(:x), s(:var_int, :x)
  end

  def test_symbolic_int_add
    x = LazyZ3::var_int(:x)
    assert_equal (5 + x).to_s, s(:send, :+, s(:const, 5), x).to_s
    assert_equal (x + 5).to_s, s(:send, :+, x, s(:const, 5)).to_s
    assert_equal (x + x).to_s, s(:send, :+, x, x).to_s
  end

  def test_symbolic_int_sub
    x = LazyZ3::var_int(:x)
    assert_equal (5 - x).to_s, s(:send, :-, s(:const, 5), x).to_s
    assert_equal (x - 5).to_s, s(:send, :-, x, s(:const, 5)).to_s
    assert_equal (x - x).to_s, s(:send, :-, x, x).to_s
  end

  def test_symbolic_int_mul
    x = LazyZ3::var_int(:x)
    assert_equal (5 * x).to_s, s(:send, :*, s(:const, 5), x).to_s
    assert_equal (x * 5).to_s, s(:send, :*, x, s(:const, 5)).to_s
    assert_equal (x * x).to_s, s(:send, :*, x, x).to_s
  end

  def test_symbolic_int_div
    x = LazyZ3::var_int(:x)
    assert_equal (5 / x).to_s, s(:send, :"/", s(:const, 5), x).to_s
    assert_equal (x / 5).to_s, s(:send, :"/", x, s(:const, 5)).to_s
    assert_equal (x / x).to_s, s(:send, :"/", x, x).to_s
  end

  def test_symbolic_int_eql
    x = LazyZ3::var_int(:x)
    assert_equal (5 == x).to_s, s(:send, :"==", s(:const, 5), x).to_s
    assert_equal (x == 5).to_s, s(:send, :"==", x, s(:const, 5)).to_s
    assert_equal (x == x).to_s, s(:send, :"==", x, x).to_s
  end

  def test_symbolic_int_neq
    x = LazyZ3::var_int(:x)
    assert_equal (5 != x).to_s, s(:send, :"!=", s(:const, 5), x).to_s
    assert_equal (x != 5).to_s, s(:send, :"!=", x, s(:const, 5)).to_s
    assert_equal (x != x).to_s, s(:send, :"!=", x, x).to_s
  end

  def test_symbolic_int_lt
    x = LazyZ3::var_int(:x)
    assert_equal (5 < x).to_s, s(:send, :"<", s(:const, 5), x).to_s
    assert_equal (x < 5).to_s, s(:send, :"<", x, s(:const, 5)).to_s
    assert_equal (x < x).to_s, s(:send, :"<", x, x).to_s
  end

  def test_symbolic_int_gt
    x = LazyZ3::var_int(:x)
    assert_equal (5 > x).to_s, s(:send, :">", s(:const, 5), x).to_s
    assert_equal (x > 5).to_s, s(:send, :">", x, s(:const, 5)).to_s
    assert_equal (x > x).to_s, s(:send, :">", x, x).to_s
  end

  def test_symbolic_int_leq
    x = LazyZ3::var_int(:x)
    assert_equal (5 <= x).to_s, s(:send, :"<=", s(:const, 5), x).to_s
    assert_equal (x <= 5).to_s, s(:send, :"<=", x, s(:const, 5)).to_s
    assert_equal (x <= x).to_s, s(:send, :"<=", x, x).to_s
  end

  def test_symbolic_int_geq
    x = LazyZ3::var_int(:x)
    assert_equal (5 >= x).to_s, s(:send, :">=", s(:const, 5), x).to_s
    assert_equal (x >= 5).to_s, s(:send, :">=", x, s(:const, 5)).to_s
    assert_equal (x >= x).to_s, s(:send, :">=", x, x).to_s
  end

  def test_symbolic_bool_and
    x = LazyZ3::var_int(:x)
    assert_equal (true & x).to_s, s(:send, :"&", s(:const, true), x).to_s
    assert_equal (x & false).to_s, s(:send, :"&", x, s(:const, false)).to_s
    assert_equal (x & x).to_s, s(:send, :"&", x, x).to_s
  end

  def test_symbolic_bool_or
    x = LazyZ3::var_int(:x)
    assert_equal (true | x).to_s, s(:send, :"|", s(:const, true), x).to_s
    assert_equal (x | false).to_s, s(:send, :"|", x, s(:const, false)).to_s
    assert_equal (x | x).to_s, s(:send, :"|", x, x).to_s
  end

  def test_symbolic_bool_not
    x = LazyZ3::var_int(:x)
    assert_equal (!x).to_s, s(:send, :!, x).to_s
  end

  def test_unsat
    x = LazyZ3::var_bool(:x)
    expr = x & (!x)
    refute LazyZ3::solve(expr)
  end

  def test_valid
    x = LazyZ3::var_int(:x)
    expr = ((x - x) == 0)
    assert LazyZ3::solve(expr)
  end
end
