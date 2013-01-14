class Object
  def to_csv(options={})
    AsCSV::CSVBuilder.new(self, options).to_csv
  end
end
