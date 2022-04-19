# frozen_string_literal: true

require "ast"

module LazyZ3
  class Error < StandardError; end
end

def ss(kind, *children)
  LazyZ3::Z3Node.new(kind, children)
end

require_relative "lazyz3/version"
require_relative "lazyz3/extensions"
require_relative "lazyz3/evaluator"
