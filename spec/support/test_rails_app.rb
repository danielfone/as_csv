#
# This single file defines an entire Rails app, which is used for testing
#
require 'action_controller/railtie'
require 'active_record/railtie'
require 'as_csv'

# Configure in-memory db
ENV['DATABASE_URL'] = 'sqlite3::memory:'

# A minimal test rails application
class TestRailsApp < Rails::Application
  config.eager_load = false
end

# Define our models
class Widget < ActiveRecord::Base
end

class WidgetWithOptions < Widget

  def as_csv(options={})
    style = options[:style] || raise("options[:style] not set")
    case style
    when :full then attributes.slice('name', 'code').merge({:full => true})
    when :short then attributes.slice('name', 'code')
    end
  end

end

# Define our controller
class RenderWidgetsController < ActionController::Base

  def index
    respond_to do |format|
      format.csv { render :csv => WidgetWithOptions.all, :style => :full }
    end
  end

  def show
    respond_to do |format|
      format.csv { render :csv => Widget.find(params[:id]) }
    end
  end

end

# Initialize the rails app
TestRailsApp.initialize!

# Create our in-memory database
ActiveRecord::Schema.define(version: 1) do
  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "code"
  end
end

# Define our routes
Rails.application.routes.draw do
  resources :render_widgets
  resources :respond_with_widgets
end
