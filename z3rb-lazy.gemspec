# frozen_string_literal: true

require_relative "lib/lazyz3/version"

Gem::Specification.new do |spec|
  spec.name          = "lazyz3"
  spec.version       = LazyZ3::VERSION
  spec.authors       = ["Sankha Narayan Guria"]
  spec.email         = ["sankha93@gmail.com"]

  spec.summary       = "Manipulate Z3 ASTs lazily"
  spec.homepage      = "https://github.com/ngsankha/z3rb-lazy"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ngsankha/z3rb-lazy"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "minitest", "~> 5.0"
  # spec.add_dependency "z3", "~> 0.0.20220320"
  spec.add_dependency "ast", "~> 2.4"
  spec.add_dependency "pycall", "~> 1.4"
  spec.add_dependency "warning", "~> 1.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
