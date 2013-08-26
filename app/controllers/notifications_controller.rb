class NotificationsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def create
    message = Notifier.new(pushable_ids).send!
    redirect_to panel_index_path, notice: message
  end

  private

  def pushable_ids
    Device.android.pushable.pluck(:push_token)
  end
end
