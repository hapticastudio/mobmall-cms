class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string   :token
      t.string   :push_token
      t.string   :operating_system
      t.string   :app_version
      t.datetime :last_request_at

      t.timestamps
    end
  end
end
