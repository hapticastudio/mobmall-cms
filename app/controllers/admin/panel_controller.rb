module Admin
  class PanelController < ApplicationController
    before_filter :require_login

    def index
    end
  end
end
