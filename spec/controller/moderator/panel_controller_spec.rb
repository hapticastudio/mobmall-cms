require 'spec_helper'

describe Moderator::PanelController, type: :controller do
  context "index" do
    it "should block unauthenticated" do
      get :index
      assert_redirected_to root_url
    end

    it "should render :index" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)

      get :index
      assert_template :index
    end
  end
end
