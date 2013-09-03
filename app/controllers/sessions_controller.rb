class SessionsController < ApplicationController
  def new
    redirect_to path_params if logged_in?
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to path_params, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  def path_params
    {controller: "#{current_user.role}/panel", action: "index"}
  end
end
