module Admin
  class LocalsController < AdminController
    def index
      @locals = Local.all
    end

    def new
      @local = Local.new
    end

    def create
      @local = Local.new(local_params)
      if @local.save
        redirect_to edit_local_path(@local)
      else
        render :new
      end
    end

    private

    def local_params
      params.require(:local).permit(:name)
    end
  end
end
