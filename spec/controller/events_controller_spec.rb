require 'spec_helper'

describe EventsController, type: :controller do
  context "new" do
    it "should block unauthenticated" do
      local = FactoryGirl.create(:local)
      get :new, local_id: local.id
      assert_redirected_to root_url
    end

    it "should block non-moderators" do
      local = FactoryGirl.create(:local)
      login_as_user
      get :new, local_id: local.id
      assert_redirected_to root_url
    end

    it "should render :new for moderator" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      get :new, local_id: local.id
      assert_template :new
    end
  end

  context "create" do
    it "should block unauthenticated" do
      local = FactoryGirl.create(:local)
      post :create, local_id: local.id, event: { description: "something" }
      assert_redirected_to root_url
    end

    it "should block non-moderators" do
      local = FactoryGirl.create(:local)
      login_as_user
      post :create, local_id: local.id, event: { description: "something" }
      assert_redirected_to root_url
    end

    it "should render :new on errors" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      post :create, local_id: local.id, event: { description: "" }
      assert_template :new
    end

    it "should redirect to local edit on success" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      post :create, local_id: local.id, event: { description: "something", begin_time: Time.now, end_time: 2.day.from_now }
      assert_redirected_to edit_local_path(local)
    end
  end
end
