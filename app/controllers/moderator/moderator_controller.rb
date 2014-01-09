module Moderator
  class ModeratorController < ApplicationController
    before_filter :require_login
    before_filter :require_moderator

    private

    def local
      @local ||= current_user.local
    end

    def require_moderator
      not_authorised unless current_user.moderator? and local
    end
  end
end
