class Users::SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    sign_in!(:scope => resource_name, :recall => "#{controller_path}#new")
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :user => current_user
           }
  end

  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
           }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Credentials Failed"
           }
  end

  def show_current_user
    sign_in!(:scope => resource_name, :recall => "#{controller_path}#new")
    render :status => 200,
           :json => { :success => true,
                      :info => "Current User",
                      :user => current_user
           }

  end
end