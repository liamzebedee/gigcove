Rails.application.assets.context_class.instance_eval do
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
end