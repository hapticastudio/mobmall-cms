module Moderator
  class LocalsController < ApplicationController
    before_filter :require_login
    before_filter :require_moderator

    def show
      @events          = local.events
      @current_content = local.contents.last
    end

    private

    def local
      @local ||= Local.where(id_params).first
    end

    def require_moderator
      not_authorised unless local.moderator == current_user
    end
  end
end
