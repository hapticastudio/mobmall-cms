class ChangeUserRoleDefaultToModerator < ActiveRecord::Migration
  def change
    change_column_default :users, :role, 'moderator'
  end
end
