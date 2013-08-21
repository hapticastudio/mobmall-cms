require 'spec_helper'

describe UsersController, type: :controller do
  context "index" do
    it "should block unauthenticated" do
      get :index
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      get :index
      assert_redirected_to root_url
    end

    it "should render :index" do
      login_as_admin
      get :index
      assert_template :index
    end
  end

  context "new" do
    it "should block unauthenticated" do
      get :new
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      get :new
      assert_redirected_to root_url
    end
  end

  context "create" do
    it "should block unauthenticated" do
      post :create
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      post :create
      assert_redirected_to root_url
    end

    it "should redirect to panel on success" do
      login_as_admin
      post :create, user: FactoryGirl.attributes_for(:user)
      assert_redirected_to panel_index_path
    end

    it "should render :new on failes creation" do
      login_as_admin
      post :create, user: {name: "is not enough"}
      assert_template :new
    end
  end

  context "promote" do
    it "should block unauthenticated" do
      patch :promote, id: 1
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      patch :promote, id: 1
      assert_redirected_to root_url
    end

    it "should redirect to users path" do
      login_as_admin
      patch :promote, id: FactoryGirl.create(:user).id
      assert_redirected_to users_path
    end
  end

  context "degrade" do
    it "should block unauthenticated" do
      patch :degrade, id: 1
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      patch :degrade, id: 1
      assert_redirected_to root_url
    end

    it "should redirect to users path" do
      login_as_admin
      patch :degrade, id: FactoryGirl.create(:user).id
      assert_redirected_to users_path
    end
  end

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
      assert_redirected_to panel_index_path
    end

    it "should render new on failed update" do
      user = FactoryGirl.create(:user)
      login_user(user)
      patch :update, id: user.id, user: {password: "new", password_confirmation: ""}
      assert_template :edit
    end
  end

  context "destroy" do
    it "should block unauthenticated" do
      delete :destroy, id: 1
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      delete :destroy, id: 1
      assert_redirected_to root_url
    end

    it "should redirect to users_path" do
      login_as_admin
      delete :destroy, id: FactoryGirl.create(:user).id
      assert_redirected_to users_path
    end
  end
end
