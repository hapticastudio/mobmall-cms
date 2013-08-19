class LocalsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, except: [:edit, :update]
  
  def index
    @locals = Local.all
  end

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
    @local = resource
    not_authorised unless @local.moderator == current_user or current_user.admin?
    @possible_moderators = User.moderators
  end

  def update
    @local = resource
    not_authorised unless @local.moderator == current_user or current_user.admin?

    if @local.update_attributes(edit_params)
      redirect_to panel_index_path
    else
      @possible_moderators = User.moderators
      render :edit
    end
  end

  private

  def resource
    Local.where(id_params).first
  end

  def edit_params
    if current_user.admin?
      params.require(:local).permit(:user_id)
    else
      params.require(:local).permit(:name)
    end
  end

  def local_params
    params.require(:local).permit(:name)
  end
end
