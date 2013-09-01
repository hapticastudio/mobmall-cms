class DevicesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @devices = Device.all
  end

  def destroy
    Device.destroy_all
    redirect_to devices_path
  end
end
