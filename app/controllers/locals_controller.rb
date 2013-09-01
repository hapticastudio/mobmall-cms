class LocalsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, only: [:index, :new, :create]
  before_filter :require_moderator_or_admin, only: [:show, :edit, :update]

  def index
    @locals = Local.all
  end

  def show
    @events = @local.events
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
    @possible_moderators = User.moderators if current_user.admin?
  end

  def update
    if resource.update_attributes(edit_params)
      redirect_to local_path(resource)
    else
      @possible_moderators = User.moderators if current_user.admin?
      render :edit
    end
  end

  private

  def require_moderator_or_admin
    not_authorised unless resource.moderator == current_user or current_user.admin?
  end

  def resource
    @local ||= Local.where(id_params).first
  end

  def edit_params
    if current_user.admin?
      params.require(:local).permit(:user_id)
    else
      params.require(:local).permit(:name, :description, :tag_list)
    end
  end

  def local_params
    params.require(:local).permit(:name)
  end
end
