class LocalContentsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @unconfirmed_contents = Local::Content.unconfirmed
  end

  def confirm
    Local::Content.where(id_params).first.confirm!
    redirect_to local_contents_path
  end

  def reject
    Local::Content.where(id_params).first.reject!
    redirect_to local_contents_path
  end
end
