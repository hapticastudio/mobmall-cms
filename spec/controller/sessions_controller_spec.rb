require 'spec_helper'

describe SessionsController, type: :controller do
  context "new" do
    it "should render :new unless logged in" do
      get :new
      assert_template :new
    end

    it "should redirect to panel if user logged in" do
      login_as_user
      get :new
      assert_response :redirect
    end
  end

  context "create" do
    it "redirects to panel on success" do
      user = FactoryGirl.create(:user)
      post :create, email: user.email, password: "secret"
      assert_response :redirect
    end

    it "renders new on fail" do
      post :create
      assert_template :new
    end
  end

  context "destroy" do
    it "redirects to root" do
      delete :destroy
      assert_redirected_to root_url
    end
  end
end
