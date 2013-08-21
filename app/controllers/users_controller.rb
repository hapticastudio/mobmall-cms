class UsersController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, except: [:edit, :update]
  before_filter :require_matching_users, only: [:edit, :update]

  def index
    @users = User.ordered
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.deliver_reset_password_instructions!
      redirect_to panel_index_path, notice: "User successfully created"
    else
      render :new
    end
  end

  def promote
    resource.promote! 
    redirect_to users_path
  end

  def degrade
    resource.degrade! 
    redirect_to users_path
  end

  def edit
  end

  def update
    if resource.update_attributes(password_params)
      redirect_to panel_index_path, notice: "Account updated successfully"
    else
      render :edit
    end
  end

  def destroy
    resource.destroy
    redirect_to users_path, notice: "User #{resource.email} successfully removed"
  end

  private

  def resource
    @user ||= User.where(id_params).first
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def require_matching_users
    not_authorised unless resource == current_user
  end
end
