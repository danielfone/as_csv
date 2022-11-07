#
# This single file defines an entire Rails app, which is used for testing
#
require 'action_controller/railtie'
require 'active_record/railtie'
require 'responders'
require 'as_csv'

# Initialize in-memory db
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Schema.define(version: 1) do

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "code"
  end

end

class Widget < ActiveRecord::Base
end

class WidgetWithOptions < Widget

  def as_csv(options={})
    style = options[:style] || raise("options[:style] not set")
    case style
    when :full then attributes.slice('name', 'code').merge({:full => true})
    when :short then attributes.slice('name', 'code')
    else raise "options[:style] must be :full or :short"
    end
  end

end

# A minimal test rails application
class TestRailsApp < Rails::Application
  config.eager_load = false
  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger

  routes.draw do
    resources :render_widgets
    resources :respond_with_widgets
  end
end

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

class RespondWithWidgetsController < ActionController::Base
  respond_to :csv

  def index
    respond_with WidgetWithOptions.all, :style => :full
  end

  def show
    respond_with Widget.find(params[:id])
  end

end
