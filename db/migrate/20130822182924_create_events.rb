class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text     :description
      t.integer  :local_id
      t.datetime :begin_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
