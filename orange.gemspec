# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orange/version'

Gem::Specification.new do |spec|
  spec.name          = "orange"
  spec.version       = Orange::VERSION
  spec.authors       = ["César Ravelo Martínez", "Ayose Castillo Barroso"]
  spec.email         = ["alu0100511314@ull.edu.es", "alu0100600810@ull.edu.es"]
  spec.summary       = %q{Gema para la implementación de un naranjero}
  spec.description   = %q{Gema para la implementación del comportamiento de un naranjero}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "lib/orange"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.11"

  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "coveralls"
end

