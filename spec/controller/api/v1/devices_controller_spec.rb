require 'spec_helper'

describe Api::V1::DevicesController, type: :controller do
  context "create" do
    it "responds with :ok and token if successfull" do
      post :create, device: {app_version: "1.0.0"}
      assert json
      assert_response :ok
    end

    it "returns error when app version is not sent" do
      post :create, device: {app_version: ""}
      json["errors"].should == ["App version can't be blank"]
      assert_response :unprocessable_entity
    end
  end

  context "update" do
    it "responds with :unprocessable_entity if errors" do
      device = FactoryGirl.create(:device)
      Device.any_instance.stub(update_attributes: false)
      patch :update, id: device.token, device: {operating_system: "ios"}
      json["errors"].should be
      assert_response :unprocessable_entity
    end

    it "should respond with :ok on success" do
      device = FactoryGirl.create(:device)
      patch :update, id: device.token, device: {operating_system: "ios"}
      assert_response :ok
    end
  end
end
