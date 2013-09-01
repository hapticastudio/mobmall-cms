class UpdateExistingUsersRole < ActiveRecord::Migration
  def up
    User.where(role: nil).each do |user|
      user.update_attribute(:role, 'moderator')
    end
  end

  def down
    User.where(role: 'moderator').each do |user|
      user.update_attribute(:role, nil)
    end
  end
end
