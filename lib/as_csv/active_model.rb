if defined? ActiveModel::Serialization
  module ActiveModel::Serialization
    def as_csv(options={})
      attributes
    end

    def to_csv(*args)
      [self].to_csv(*args)
    end
  end
end
