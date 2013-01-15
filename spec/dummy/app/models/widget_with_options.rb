class WidgetWithOptions < Widget

  def as_csv(options={})
    style = options[:style] || raise("options[:style] not set")
    case style
    when :full then attributes.slice('name', 'code').merge({:full => true})
    when :short then attributes.slice('name', 'code')
    else raise "options[:style] must be :full or :short"
    end
  end

end
