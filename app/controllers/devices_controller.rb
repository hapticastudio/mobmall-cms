class DevicesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @devices = Device.all
  end
end
