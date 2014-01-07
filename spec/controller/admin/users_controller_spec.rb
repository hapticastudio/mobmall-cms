require 'spec_helper'

describe Admin::UsersController, type: :controller do
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

    it "should render :new" do
      login_as_admin
      get :new
      assert_template :new
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
      assert_redirected_to admin_panel_index_path
    end

    it "should render :new on failes creation" do
      login_as_admin
      post :create, user: {email: ""}
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
      assert_redirected_to admin_users_path
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
      assert_redirected_to admin_users_path
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

    it "should redirect to admin_users_path" do
      login_as_admin
      delete :destroy, id: FactoryGirl.create(:user).id
      assert_redirected_to admin_users_path
    end
  end
end
