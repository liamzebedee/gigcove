class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :url_with_host
  def url_with_host(url)
    URI::join("http://gigcove.com/", url)
  end
end
