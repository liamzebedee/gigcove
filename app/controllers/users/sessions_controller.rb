class Users::SessionsController < Devise::SessionsController
  def new
    @page_title = "Sign in"
    @page_description = "Use details to sign into your account on GigCove."
    render 'users/sessions/new'
  end
  
  # These methods are necessary to define as this isn't a standard Devise controller
  # http://stackoverflow.com/questions/4081744/devise-form-within-a-different-controller
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
