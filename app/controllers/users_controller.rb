class UsersController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @users = User.all
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

  def destroy
    @user = User.find(destroy_params[:id])
    @user.destroy if @user
    redirect_to users_path, notice: "User #{@user.email} successfully removed"
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def destroy_params
    params.permit(:id)
  end
end
