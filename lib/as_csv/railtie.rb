require 'as_csv/csv_builder'

module ActiveModel::Serialization
  def as_csv(options={})
    attributes
  end

  def to_csv(*args)
    AsCSV::CSVBuilder.new(self, *args).to_csv
  end
end

module ActiveRecord
  class Relation
    def as_csv(options = {})
      attributes
    end

    def to_csv(*args)
      AsCSV::CSVBuilder.new(self, *args).to_csv
    end
  end
end

ActionController::Renderers.add :csv do |obj, options|
  response.headers['Content-Disposition'] = 'attachment'
  obj.respond_to?(:to_csv) ? obj.to_csv(options) : obj
end
