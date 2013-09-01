class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :events, :local_id
    add_index :local_contents, :local_id
    add_index :locals, :user_id
    add_index :taggings, :local_id
    add_index :taggings, :tag_id
    add_index :tags, :local_id
  end
end
