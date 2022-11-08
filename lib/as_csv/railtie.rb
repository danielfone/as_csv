require 'as_csv/active_model/serialization/csv'

ActiveModel::Serialization.send :include, AsCSV::ActiveModel::Serialization::CSV

ActionController::Renderers.add :csv do |obj, options|
  response.headers['Content-Disposition'] = 'attachment'
  obj.respond_to?(:to_csv) ? obj.to_csv(options) : obj
end
