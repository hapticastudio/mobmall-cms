require 'spec_helper'

describe Api::V1::ContentController, type: :controller do
  context "index" do
    it "responds with :forbidden if no token available" do
      get :index
      assert_response :forbidden
    end

    it "responds with content if token passed" do
      device = FactoryGirl.create(:device)
      FactoryGirl.create(:local)
      get :index, id: device.token

      expected_json = {
        'content' => {
          'places' => [
            {
              'id' => 1,
              'name' => "MacDonalds",
              'description' => ""
            }
          ]
        }
      }

      json.should == expected_json
    end
  end
end
