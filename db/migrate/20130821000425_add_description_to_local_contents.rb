class AddDescriptionToLocalContents < ActiveRecord::Migration
  def change
    add_column :local_contents, :description, :text, default: ""
  end
end
