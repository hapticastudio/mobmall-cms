require 'spec_helper'

describe Api::V1::ContentController, type: :controller do
  context "index" do
    it "responds with :forbidden if no token available" do
      get :index
      assert_response :forbidden
    end

    it "responds with content if token passed" do
      device = FactoryGirl.create(:device)
      local = FactoryGirl.create(:local)
      event = FactoryGirl.create(:event, local: local)
      tag   = FactoryGirl.create(:tag, locals: [local])
      get :index, token: device.token

      expected_json = {
        'content' => {
          'places' => [
            {
              'id' => local.id,
              'name' => local.name,
              'description' => local.description
            }
          ],
          'events' => [
            {
              "id" => event.id,
              "description" => event.description,
              "local_id" => event.local_id,
              "begin_time" => event.begin_time,
              "end_time" => event.end_time,
              "name" => event.name,
              "short_description" => event.short_description
            }
          ],
          'tags' => [
            'id' => tag.id,
            'name' => tag.name,
            'local_ids' => [local.id]
          ]
        }
      }

      json.should == expected_json
    end

    it "filters content by edit time, when :updated_since param passed" do
      device = FactoryGirl.create(:device)
      FactoryGirl.create(:local, updated_at: 2.days.ago)
      FactoryGirl.create(:local, updated_at: 2.days.ago)
      local = FactoryGirl.create(:local)

      FactoryGirl.create(:event, updated_at: 2.days.ago)
      FactoryGirl.create(:event, updated_at: 2.days.ago)
      event = FactoryGirl.create(:event, local: local)

      FactoryGirl.create(:tag, updated_at: 2.days.ago)
      FactoryGirl.create(:tag, updated_at: 2.days.ago)
      tag = FactoryGirl.create(:tag, locals: [local])

      get :index, token: device.token, updated_since: 1.day.ago

      expected_json = {
        'content' => {
          'places' => [
            {
              'id' => local.id,
              'name' => local.name,
              'description' => local.description
            }
          ],
          'events' => [
            {
              "id" => event.id,
              "description" => event.description,
              "local_id" => event.local_id,
              "begin_time" => event.begin_time,
              "end_time" => event.end_time,
              "name" => event.name,
              "short_description" => event.short_description
            }
          ],
          'tags' => [
            'id' => tag.id,
            'name' => tag.name,
            'local_ids' => [local.id]
          ]
        }
      }

      json.should == expected_json
    end
  end
end
