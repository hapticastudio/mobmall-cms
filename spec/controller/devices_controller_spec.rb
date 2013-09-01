require 'spec_helper'

describe DevicesController, type: :controller do
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
      FactoryGirl.create(:device)
      login_as_admin
      get :index
      assert_template :index
    end
  end

  context "index" do
    it "should block unauthenticated" do
      delete :destroy
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      delete :destroy
      assert_redirected_to root_url
    end

    it "should render :index" do
      FactoryGirl.create(:device)
      login_as_admin
      delete :destroy
      assert_redirected_to devices_path
    end
  end
end
