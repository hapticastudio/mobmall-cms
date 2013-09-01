require 'spec_helper'

describe LocalContentsController, type: :controller do
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

  context "confirm" do
    it "should block unauthenticated" do
      patch :confirm, id: "fake_id"
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      patch :confirm, id: "fake_id"
      assert_redirected_to root_url
    end

    it "should redirect to index" do
      login_as_admin
      content = FactoryGirl.create(:local_content)
      patch :confirm, id: content.id
      assert_redirected_to local_contents_path
    end
  end

  context "reject" do
    it "should block unauthenticated" do
      patch :reject, id: "fake_id"
      assert_redirected_to root_url
    end

    it "should block non-admins" do
      login_as_user
      patch :reject, id: "fake_id"
      assert_redirected_to root_url
    end

    it "should redirect to index" do
      login_as_admin
      content = Local::Content.create
      patch :reject, id: content.id
      assert_redirected_to local_contents_path
    end
  end
end
