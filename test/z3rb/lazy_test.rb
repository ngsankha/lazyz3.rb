# frozen_string_literal: true

require "test_helper"

class Z3rb::LazyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Z3rb::Lazy::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
