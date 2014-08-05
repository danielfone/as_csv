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

  gem.add_development_dependency "rails", "~> 3.2.0"
  gem.add_development_dependency "sqlite3" unless defined? JRUBY_VERSION

  # Tests
  gem.add_development_dependency "rspec-rails", "~> 2.13.0"
  gem.add_development_dependency "simplecov"
end
