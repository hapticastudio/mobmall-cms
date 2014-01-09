require 'spec_helper'

describe Moderator::EventsController, type: :controller do
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

    it "should redirect to local show on success" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      post :create, local_id: local.id, event: FactoryGirl.attributes_for(:event)
      assert_redirected_to moderator_local_path(local)
    end
  end

  context "edit" do
    it "should block unauthenticated" do
      local = FactoryGirl.create(:local)
      get :edit, local_id: local.id, id: "fake_id"
      assert_redirected_to root_url
    end

    it "should block non-moderators" do
      local = FactoryGirl.create(:local)
      event = FactoryGirl.create(:event, local: local)
      login_as_user
      get :edit, local_id: local.id, id: event.id
      assert_redirected_to root_url
    end

    it "should render :edit for moderator" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      event = FactoryGirl.create(:event, local: local)
      login_user(user)
      get :edit, local_id: local.id, id: event.id
      assert_template :edit
    end
  end

  context "update" do
    it "should block unauthenticated" do
      local = FactoryGirl.create(:local)
      post :update, local_id: local.id, id: "fake_id", event: { description: "something" }
      assert_redirected_to root_url
    end

    it "should block non-moderators" do
      local = FactoryGirl.create(:local)
      event = FactoryGirl.create(:event, local: local)
      login_as_user
      post :update, local_id: local.id, id: event.id, event: { description: "something" }
      assert_redirected_to root_url
    end

    it "should render :new on errors" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      event = FactoryGirl.create(:event, local: local)
      login_user(user)
      post :update, local_id: local.id, id: event.id, event: { description: "" }
      assert_template :edit
    end

    it "should redirect to local show on success" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      event = FactoryGirl.create(:event, local: local)
      login_user(user)
      post :update, local_id: local.id, id: event.id, event: { description: "something", begin_time: Time.now, end_time: 2.day.from_now }
      assert_redirected_to moderator_local_path
    end
  end
end
