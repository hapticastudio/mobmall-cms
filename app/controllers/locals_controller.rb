class LocalsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin
  
  def new
    @local = Local.new
  end

  def create
    @local = Local.new(local_params)
    if @local.save
      redirect_to panel_index_path
    else
      render :new
    end  
  end

  private

  def local_params
    params.require(:local).permit(:name)
  end
end
