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
end
