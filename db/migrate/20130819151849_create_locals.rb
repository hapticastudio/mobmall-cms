class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      t.timestamps
    end
  end
end
