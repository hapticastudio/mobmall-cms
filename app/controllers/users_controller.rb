class UsersController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, except: [:edit, :update]

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
    @user = User.find(id_params[:id])
    @user.promote! 
    redirect_to users_path
  end

  def degrade
    @user = User.find(id_params[:id])
    @user.degrade! 
    redirect_to users_path
  end

  def edit
    @user = User.find(id_params[:id])
    not_authorised unless @user == current_user
  end

  def update
    @user = User.find(id_params[:id])
    not_authorised unless @user == current_user
    if @user.update_attributes(password_params)
      redirect_to panel_index_path, notice: "Account updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(id_params[:id])
    @user.destroy if @user
    redirect_to users_path, notice: "User #{@user.email} successfully removed"
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
