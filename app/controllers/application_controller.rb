class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # def login_required
  #   unless current_user
  #     session[:return_to] = request.env["REQUEST_URI"]
  #     flash[:error] = "Login required"
  #     redirect_to new_user_session_path
  #   end
  # end

  def admin?
    if current_user.admin
      true
    else
      flash[:error] = "Permission denied"
      redirect_to root_path
    end
  end

  private
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end

    # def stored_location_for
    #   return nil
    # end

end
