class Array
  def to_csv_with_builder(opts={})
    AsCSV::CSVBuilder.new(self, opts).to_csv || to_csv_without_builder
  end
  alias_method :to_csv_without_builder, :to_csv
  alias_method :to_csv, :to_csv_with_builder
end
