require 'spec_helper'

describe Admin::LocalsController, type: :controller do
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
      post :create, local: FactoryGirl.attributes_for(:local)
      assert_redirected_to edit_local_path(Local.last)
    end

    it "should render :new on failed creation" do
      login_as_admin
      post :create, local: {name: ""}
      assert_template :new
    end
  end
end
