class CreateLocalContents < ActiveRecord::Migration
  def change
    create_table :local_contents do |t|
      t.string     :name
      t.references :local
      t.timestamps
    end
  end
end
