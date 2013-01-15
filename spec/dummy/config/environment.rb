# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dummy::Application.initialize!

# Initialize in-memory db
load File.join(Rails.root, "db/schema.rb")
