require 'spec_helper'

describe Moderator::LocalsController, type: :controller do
  context "show" do
    it "should block unauthenticated" do
      get :show, id: 1
      assert_redirected_to root_url
    end

    it "should allow moderator" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      FactoryGirl.create(:event, local: local)
      login_user(user)
      get :show, id: local.id
      assert_template :show
    end

    it "should not allow stranger" do
      login_as_user
      get :show, id: FactoryGirl.create(:local).id
      assert_redirected_to root_url
    end
  end
end
