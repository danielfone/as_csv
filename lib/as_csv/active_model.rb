if defined? ActiveModel::Serialization
  module ActiveModel::Serialization
    def as_csv(options={})
      attributes
    end

    def to_csv(options={})
      AsCSV::CSVBuilder.new(self, options).to_csv
    end
  end
end
