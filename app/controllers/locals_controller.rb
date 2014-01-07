class LocalsController < ApplicationController
  before_filter :require_login
  before_filter :require_moderator_or_admin, only: [:edit, :update]

  def edit
    @possible_moderators = User.moderators if current_user.admin?
  end

  def update
    if resource.update_attributes(edit_params)
      if current_user.admin?
        redirect_to locals_path
      else
        redirect_to moderator_local_path(resource)
      end
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
      params.require(:local).permit(:user_id, :poi)
    else
      params.require(:local).permit(:name, :description, :tag_list)
    end
  end

  def local_params
    params.require(:local).permit(:name)
  end
end
