# -*- encoding: utf-8 -*-
require File.expand_path '../lib/as_csv/version', __FILE__

Gem::Specification.new do |gem|
  gem.name          = "as_csv"
  gem.version       = AsCSV::VERSION
  gem.authors       = ["Daniel Fone"]
  gem.email         = %w[daniel@fone.net.nz]
  gem.description   = %q{Instant CSV support for Rails}
  gem.summary       = %q{Instant CSV support for Rails}
  gem.homepage      = "https://github.com/danielfone/as_csv"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w[lib]

  gem.add_runtime_dependency "activemodel", '>= 7.0'
  gem.add_runtime_dependency "actionpack", '>= 7.0'
  gem.add_runtime_dependency "responders"

  # Tests
  gem.add_development_dependency "rails", "~> 7.0"
  gem.add_development_dependency "sqlite3" unless defined? JRUBY_VERSION
  gem.add_development_dependency "rspec-rails", "~> 5.1"
  gem.add_development_dependency "simplecov"
end
