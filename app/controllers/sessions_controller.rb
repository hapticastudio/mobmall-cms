class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end
end
