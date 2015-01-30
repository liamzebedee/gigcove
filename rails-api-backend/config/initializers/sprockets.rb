Rails.application.assets.context_class.class_eval do
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
end
Sprockets::Context.send :include, Rails.application.routes.url_helpers
Sprockets::Context.send :include, ActionView::Helpers