if defined? ActiveModel::Serialization
  module ActiveModel::Serialization
    def as_csv(options={})
      attributes
    end
  end
end
