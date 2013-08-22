require 'spec_helper'

describe Api::V1::DevicesController, type: :controller do
  context "create" do
    it "responds with :ok and token if successfull" do
      post :create, device: {app_version: "1.0.0"}
      json["device"]["token"].should be
      assert_response :ok
    end

    it "returns error when app version is not sent" do
      post :create, device: {app_version: ""}
      json["errors"].should == ["App version can't be blank"]
      assert_response :unprocessable_entity
    end
  end

  context "update" do
    it "responds with :forbidden if no device found" do
      patch :update, id: "invalid_token"
      assert_response :forbidden
    end

    it "responds with :unprocessable_entity if errors" do
      device = FactoryGirl.create(:device)
      Device.any_instance.stub(update_attributes: false)
      patch :update, id: device.token, device: {operating_system: "IOS"}
      json["errors"].should be
      assert_response :unprocessable_entity
    end

    it "should respond with :ok on success" do
      device = FactoryGirl.create(:device)
      patch :update, id: device.token, device: {operating_system: "IOS"}
      assert_response :ok
    end
  end
end
