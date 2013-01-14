if defined? ActionController::Renderers
  ActionController::Renderers.add :csv do |obj, options|
    obj.respond_to?(:to_csv) ? obj.to_csv(options) : obj
  end
end
