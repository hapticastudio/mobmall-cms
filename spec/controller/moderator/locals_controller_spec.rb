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

  context "edit" do
    it "should block unauthenticated" do
      get :edit, id: 1
      assert_redirected_to root_url
    end

    it "should allow mod" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      FactoryGirl.create(:event, local: local)
      login_user(user)
      get :edit, id: local.id
      assert_template :edit
    end
  end

  context "update" do
    it "should block unauthenticated" do
      patch :update, id: 1
      assert_redirected_to root_url
    end
  end
end
