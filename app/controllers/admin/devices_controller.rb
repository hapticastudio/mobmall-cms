module Admin
  class DevicesController < AdminController
    def index
      @devices = Device.all
    end

    def destroy
      Device.destroy_all
      redirect_to admin_devices_path
    end
  end
end