# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  
  layout 'active_admin_logged_out'

  def create
    # auth = request.env["omniauth.auth"]
    #     if !auth.nil? && auth["provider"] == "shibboleth"        
    #         redirect_back_or_default(root_url)
    #         return
    #     else
        password_authentication(params[:username], params[:password])
    # end   
  end
  
    
  protected
  
  def password_authentication(username, password)
    self.current_user = User.authenticate(username, password)
    if logged_in?
      successful_login
    else
      flash.now[:error] = "Authentication failed."
      render :action => 'new'
    end
  end
  
  def successful_login
    session[:limit_login_to] = nil
    redirect_back_or_default(root_path)
    flash[:notice] = "Logged in successfully"
    LoginHistory.login(self.current_user, (request.env["HTTP_X_FORWARDED_FOR"] || request.env["REMOTE_ADDR"]), request.session_options[:id])    
  end
  
end