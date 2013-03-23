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
  gem.homepage      = "https://github.com/danielfone/as_csv"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rails", "~> 3.2.0"
  gem.add_development_dependency "rspec-rails", "~> 2.13.0"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "fastercsv" if RUBY_VERSION < '1.9'
end
