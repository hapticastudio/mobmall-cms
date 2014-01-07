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
        redirect_to edit_admin_local_path(@local)
      else
        render :new
      end
    end

    def edit
      @local = Local.where(id_params).first
    end

    def update
      @local = Local.where(id_params).first
      if @local.update_attributes(edit_params)
        redirect_to admin_locals_path
      else
        render :edit
      end
    end

    private

    def edit_params
      params.require(:local).permit(:user_id, :poi)
    end

    def local_params
      params.require(:local).permit(:name)
    end
  end
end
