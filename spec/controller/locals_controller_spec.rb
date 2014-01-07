require 'spec_helper'

describe LocalsController, type: :controller do
  context "edit" do
    it "should block unauthenticated" do
      get :edit, id: 1
      assert_redirected_to root_url
    end

    it "should allow admins" do
      login_as_admin
      get :edit, id: FactoryGirl.create(:local).id
      assert_template :edit
    end

    it "should allow moderator" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      get :edit, id: local.id
      assert_template :edit
    end

    it "should not allow stranger" do
      login_as_user
      get :edit, id: FactoryGirl.create(:local).id
      assert_redirected_to root_url
    end
  end

  context "update" do
    it "should block unauthenticated" do
      patch :update, id: 1
      assert_redirected_to root_url
    end

    it "should not allow stranger" do
      login_as_user
      local = FactoryGirl.create(:local)
      patch :update, id: local.id, local: {name: "New name", description: "New description"}
      assert_redirected_to root_url
    end

    # it "should allow admin to update user_id" do
    #   login_as_admin
    #   local = FactoryGirl.create(:local)
    #   patch :update, id: local.id, local: {user_id: 2}
    #   assert_redirected_to local_path(local)
    # end

    # it "should allow moderator to update name and description" do
    #   user = FactoryGirl.create(:user)
    #   local = FactoryGirl.create(:local, moderator: user)
    #   login_user(user)
    #   patch :update, id: local.id, local: {name: "New name", description: "New description"}
    #   assert_redirected_to local_path(local)
    # end

    it "should render :edit on failed update" do
      user = FactoryGirl.create(:user)
      local = FactoryGirl.create(:local, moderator: user)
      login_user(user)
      patch :update, id: local.id, local: {name: ""}
      assert_template :edit
    end
  end
end
