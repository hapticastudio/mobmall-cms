class LocalsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin
  
  def new
    @local = Local.new
  end

  def create
    @local = Local.new(local_params)
    if @local.save
      redirect_to edit_local_path(@local)
    else
      render :new
    end  
  end

  def edit
    @local = Local.find(id_params[:id])
    @possible_moderators = User.moderators
  end

  def update
    @local = Local.find(id_params[:id])
    if @local.update_attributes(edit_params)
      redirect_to panel_index_path
    else
      @possible_moderators = User.moderators
      render :edit
    end
  end

  private

  def edit_params
    params.require(:local).permit(:user_id)
  end

  def local_params
    params.require(:local).permit(:name)
  end
end
