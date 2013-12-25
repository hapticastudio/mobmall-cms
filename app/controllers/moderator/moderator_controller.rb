module Moderator
  class ModeratorController < ApplicationController
    before_filter :require_login
    before_filter :require_moderator

    private

    def local
      @local ||= Local.where(id_params).first
    end

    def require_moderator
      not_authorised unless local.moderator == current_user
    end
  end
end
