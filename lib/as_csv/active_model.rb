if defined?(ActiveModel) && defined?(ActiveModel::Serialization)
  module ActiveModel::Serialization
    def as_csv(options)
      serializable_hash(options)
    end
  end
end
