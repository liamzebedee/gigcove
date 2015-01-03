class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #has_mobile_fu
  #debug_mobile_view = false
  #before_filter :force_mobile_format if debug_mobile_view
  
  helper_method :url_with_host
  def url_with_host(url)
    URI::join("http://gigcove.com/", url)
  end

  Rails.application.routes.default_url_options[:port]= 8080 if Rails.env.development?
end
