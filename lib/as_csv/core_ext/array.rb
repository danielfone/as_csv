require 'csv'
require 'as_csv/csv_builder'

class Array

  def to_csv_with_builder(opts={})
    use_csv_builder? and csv_builder(opts).to_csv or to_csv_without_builder
  end

  alias_method :to_csv_without_builder, :to_csv
  alias_method :to_csv, :to_csv_with_builder

private

  def use_csv_builder?
    any? { |e| e.respond_to? :as_csv }
  end

  def csv_builder(opts)
    AsCSV::CSVBuilder.new self, opts
  end

end
