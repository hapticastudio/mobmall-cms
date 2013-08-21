class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def id_params
    params.permit(:id)
  end

  def require_admin
    not_authorised unless current_user.admin?
  end

  def not_authorised
    redirect_to root_url, :alert => "You don't have permission to visit this page" and return
  end

  def not_authenticated
    redirect_to root_url, :alert => "Login to access this page"
  end
end
