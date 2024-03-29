require 'spec_helper'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

# require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require File.expand_path("../support/test_rails_app.rb",  __FILE__)
require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.infer_spec_type_from_file_location!
end
