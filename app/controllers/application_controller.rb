class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  has_mobile_fu
  # Uncomment this when debugging for mobile view
  before_filter :force_mobile_format
  
  helper_method :url_with_host
  def url_with_host(url)
    URI::join("http://gigcove.com/", url)
  end
end
