require 'csv'
require "as_csv/csv_builder"

class Array
  def to_csv_with_builder(opts={})
    if any? { |e| e.respond_to? :as_csv }
      AsCSV::CSVBuilder.new(self, opts).to_csv
    else
      to_csv_without_builder
    end
  end
  alias_method :to_csv_without_builder, :to_csv
  alias_method :to_csv, :to_csv_with_builder

end
