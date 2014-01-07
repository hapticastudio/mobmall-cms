require 'spec_helper'

describe UsersController, type: :controller do
  context "edit" do
    it "should block unauthenticated" do
      get :edit, id: 1
      assert_redirected_to root_url
    end

    it "should not allow to strangers page" do
      login_as_user
      get :edit, id: FactoryGirl.create(:user).id
      assert_redirected_to root_url
    end

    it "should render :edit" do
      user = FactoryGirl.create(:user)
      login_user(user)
      get :edit, id: user.id
      assert_template :edit
    end
  end

  context "update" do
    it "should block unauthenticated" do
      patch :update, id: 1
      assert_redirected_to root_url
    end

    it "should not allow to strangers page" do
      login_as_user
      patch :update, id: FactoryGirl.create(:user).id, user: {password: "new"}
      assert_redirected_to root_url
    end

    it "should redirect to panel on success" do
      user = FactoryGirl.create(:user)
      login_user(user)
      patch :update, id: user.id, user: {password: "new", password_confirmation: "new"}
      assert_response :redirect
    end

    it "should render new on failed update" do
      user = FactoryGirl.create(:user)
      login_user(user)
      patch :update, id: user.id, user: {password: "new", password_confirmation: ""}
      assert_template :edit
    end
  end
end
