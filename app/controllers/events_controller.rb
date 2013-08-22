class EventsController < ApplicationController
  before_filter :require_login
  before_filter :require_moderator

  def new
    @event = local.events.new
  end

  def create
    @event = local.events.new(event_params)

    if @event.save
      redirect_to local_path(local)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :begin_time, :end_time)
  end

  def local
    @local ||= Local.where(id: local_id).first
  end

  def local_id
    params.permit(:local_id)[:local_id]
  end

  def require_moderator
    not_authorised unless local.moderator == current_user
  end
end
