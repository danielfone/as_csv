require 'csv'
require 'as_csv/csv_builder'

module Enumerable

  def to_csv(opts={})
    AsCSV::CSVBuilder.new(self, opts).to_csv
  end

end
