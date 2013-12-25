module Admin
  class NotificationsController < AdminController
    def create
      message = Notifier.new(pushable_ids).send!
      redirect_to admin_panel_index_path, notice: message
    end

    private

    def pushable_ids
      Device.android.pushable.pluck(:push_token)
    end
  end
end
