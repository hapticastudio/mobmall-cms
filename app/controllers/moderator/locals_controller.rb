module Moderator
  class LocalsController < ModeratorController
    def show
      @events          = local.events
      @current_content = local.contents.last
    end
  end
end
