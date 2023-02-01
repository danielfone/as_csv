require 'as_csv/active_model/serialization/csv'

# Use the Railtie to hook into the Rails initialization process
module AsCsv
  class Railtie < Rails::Railtie

    initializer "as_csv" do

      # Include the CSV serialization module into ActiveRecord::Base and
      # ActiveModel::Serialization
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, AsCSV::ActiveModel::Serialization::CSV
        ActiveModel::Serialization.send :include, AsCSV::ActiveModel::Serialization::CSV
      end

      # Add a :csv renderer to ActionController::Renderers
      ActiveSupport.on_load :action_controller do
        ActionController::Renderers.add :csv do |obj, options|
          response.headers['Content-Disposition'] = 'attachment'
          obj.respond_to?(:to_csv) ? obj.to_csv(options) : obj
        end
      end

    end

  end
end
