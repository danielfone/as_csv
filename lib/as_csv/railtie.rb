require 'as_csv/csv_builder'

module ActiveModel::Serialization
  def as_csv(options={})
    attributes
  end

  def to_csv(*args)
    AsCSV::CSVBuilder.new(self, *args).to_csv
  end
end

ActionController::Renderers.add :csv do |obj, options|
  obj.respond_to?(:to_csv) ? obj.to_csv(options) : obj
end
