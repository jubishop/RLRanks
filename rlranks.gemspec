Gem::Specification.new do |spec|
  spec.name          = "rlranks"
  spec.version       = "1.0"
  spec.date          = "2020-05-30"
  spec.summary       = %q{A Ruby library for holding a users RL Ranks}
  spec.authors       = ["Justin Bishop"]
  spec.email         = ["jubishop@gmail.com"]
  spec.homepage      = "https://github.com/jubishop/RLRanks"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.1")
  spec.metadata["source_code_uri"] = "https://github.com/jubishop/RLRanks"
  spec.files         = Dir["lib/**/*.rb"]
  spec.add_runtime_dependency 'rstruct'
end
