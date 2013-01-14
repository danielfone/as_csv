class Object
  def to_csv(options={})
    CSVBuilder.new(self, options).to_csv
  end
end
