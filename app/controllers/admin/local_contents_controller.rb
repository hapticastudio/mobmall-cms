module Admin
  class LocalContentsController < AdminController
    def index
      @unconfirmed_contents = Local::Content.unconfirmed
    end

    def confirm
      Local::Content.where(id_params).first.confirm!
      redirect_to admin_local_contents_path
    end

    def reject
      Local::Content.where(id_params).first.reject!
      redirect_to admin_local_contents_path
    end
  end
end
