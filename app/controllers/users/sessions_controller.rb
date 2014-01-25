class Users::SessionsController < Devise::SessionsController
  def new
    @page_title = "Sign in"
    @page_description = "Sign into your account on GigCove."
    super
  end
end
