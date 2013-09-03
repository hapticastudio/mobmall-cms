require 'spec_helper'

describe Admin::NotificationsController, type: :controller do
  context "create" do
    it "should block unauthenticated" do
      post :create
      assert_redirected_to root_url
    end

    it "should redirect to panel on success" do
      login_as_admin
      Notifier.any_instance.stub(send!: true)
      post :create
      assert_redirected_to admin_panel_index_path
    end

    it "should redirect to panel on fail" do
      login_as_admin
      Notifier.any_instance.stub(send!: false)
      post :create
      assert_redirected_to admin_panel_index_path
    end
  end
end
