module Moderator
  class LocalsController < ModeratorController
    def show
      @events          = local.events
      @current_content = local.contents.last
    end

    def edit
    end

    def update
      if local.update_attributes(edit_params)
        redirect_to moderator_local_path
      else
        render :edit
      end
    end

    private

    def edit_params
      params.require(:local).permit(:name, :description, :tag_list)
    end
  end
end
