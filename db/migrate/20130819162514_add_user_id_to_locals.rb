class AddUserIdToLocals < ActiveRecord::Migration
  def change
    add_column :locals, :user_id, :integer
  end
end
