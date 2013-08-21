require 'spec_helper'

describe PanelController, type: :controller do
  context "index" do
    it "should block unauthenticated" do
      get :index
      assert_redirected_to root_url
    end

    it "should render :index" do
      login_as_user
      get :index
      assert_template :index
    end
  end
end