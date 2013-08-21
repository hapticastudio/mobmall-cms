require 'spec_helper'

describe PasswordResetsController, type: :controller do
  context "new" do
    it "should render :new" do
      get :new
      assert_template :new
    end
  end

  context "create" do
    it "should redirect to root_path" do
      post :create
      assert_redirected_to root_path
    end
  end

  context "edit" do
    it "should redirect to root if no user found" do
      get :edit, id: "false_token"
      assert_redirected_to root_path
    end

    it "should render :new if user found" do
      user = FactoryGirl.create(:user, reset_password_token: "correct_token")
      get :edit, id: "correct_token"
      assert_template :edit
    end
  end

  context "update" do
    it "should redirect to root if no user found" do
      patch :update, token: "false_token", id: "false_id"
      assert_redirected_to root_path
    end

    it "should redirect to root on success" do
      user = FactoryGirl.create(:user, reset_password_token: "correct_token")
      patch :update, token: "correct_token", id: "false_id", user: {password: "new", password_confirmation: "new"}
      assert_redirected_to root_path
    end

    it "should render :edit on fail" do
      user = FactoryGirl.create(:user, reset_password_token: "correct_token")
      patch :update, token: "correct_token", id: "false_id", user: {password: "new", password_confirmation: ""}
      assert_template :edit
    end
  end
end
