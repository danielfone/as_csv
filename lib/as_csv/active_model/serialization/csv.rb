require 'as_csv/csv_builder'

module AsCSV
  module ActiveModel
    module Serialization
      module CSV
        def as_csv(options={})
          attributes
        end

        def to_csv(*args)
          AsCSV::CSVBuilder.new(self, *args).to_csv
        end
      end
    end
  end
end
