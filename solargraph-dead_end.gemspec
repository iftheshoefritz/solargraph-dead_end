# frozen_string_literal: true

require_relative "lib/solargraph/dead_end/version"

Gem::Specification.new do |spec|
  spec.name = "solargraph-dead_end"
  spec.version = Solargraph::DeadEnd::VERSION
  spec.authors = ["Fritz Meissner"]
  spec.email = ["fritz.meissner@gmail.com"]

  spec.summary = "Solargraph DeadEnd reporter"
  spec.description = "Solargraph DeadEnd reporter"
  spec.homepage = "https://github.com/iftheshoefritz/solargraph-dead_end"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "solargraph", ">= 0.39.1"
  spec.add_runtime_dependency "dead_end"
end
