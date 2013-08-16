class SessionsController < ApplicationController
  def new
    redirect_to panel_index_path if logged_in?
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_to panel_index_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
