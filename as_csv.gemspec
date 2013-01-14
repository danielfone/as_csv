# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'as_csv/version'

Gem::Specification.new do |gem|
  gem.name          = "as_csv"
  gem.version       = AsCSV::VERSION
  gem.authors       = ["Daniel Fone"]
  gem.email         = ["daniel@fone.net.nz"]
  gem.description   = %q{Instant CSV support for Rails}
  gem.summary       = %q{Instant CSV support for Rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", "~> 2.12"
  gem.add_development_dependency "activemodel", "~> 3.2"
  gem.add_development_dependency "sqlite3-ruby"
end
