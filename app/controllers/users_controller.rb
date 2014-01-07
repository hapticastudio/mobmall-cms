class UsersController < ApplicationController
  before_filter :require_login
  before_filter :require_matching_users

  def edit
  end

  def update
    if resource.update_attributes(password_params)
      redirect_to root_path, notice: "Account updated successfully"
    else
      render :edit
    end
  end

  private

  def resource
    @user ||= User.where(id_params).first
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def require_matching_users
    not_authorised unless resource == current_user
  end
end
