class Users::RegistrationsController < Devise::RegistrationsController
	def new
		@page_title = "Join GigCove"
		@page_description = "Sign into your account on GigCove."
		super
	end

	private

	def sign_up_params
		params.require(:user).permit(:full_name, :gender, :email, :password, :password_confirmation)
	end

	def account_update_params
		params.require(:user).permit(:full_name, :gender, :email, :password, :password_confirmation, :current_password)
	end
end
