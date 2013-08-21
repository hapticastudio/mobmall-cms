class AddConfirmedToLocalContents < ActiveRecord::Migration
  def change
    add_column :local_contents, :confirmed, :boolean
  end
end
