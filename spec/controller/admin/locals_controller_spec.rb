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

    it "should render :index with local" do
      FactoryGirl.create(:local)
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
      assert_redirected_to edit_admin_local_path(Local.last)
    end

    it "should render :new on failed creation" do
      login_as_admin
      post :create, local: {name: ""}
      assert_template :new
    end
  end

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
  end

  context "update" do
    it "should block unauthenticated" do
      patch :update, id: 1
      assert_redirected_to root_url
    end

    it "should redirect to admin_locals_path on success" do
      login_as_admin
      local = FactoryGirl.create(:local)
      patch :update, id: local.id, local: {name: "New name", description: "New description"}
      assert_redirected_to admin_locals_path
    end

    it "should render :edit on failed update" do
      login_as_admin
      local = FactoryGirl.create(:local)
      Local.any_instance.stub(update_attributes: false)
      patch :update, id: local.id, local: {poi: ""}
      assert_template :edit
    end
  end
end
