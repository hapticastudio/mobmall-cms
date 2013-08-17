class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  def admin?
    role == "admin"
  end

  def password_present?
    crypted_password.present?
  end

  def title
    if admin?
      "admin"
    else
      "moderator"
    end
  end

  def promote!
    update_attribute(:role, 'admin')
  end

  def degrade!
    update_attribute(:role, nil)
  end
end
