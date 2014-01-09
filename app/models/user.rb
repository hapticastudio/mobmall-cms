class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email

  has_one :local

  scope :ordered,    -> { order(:id)               }
  scope :moderators, -> { where(role: 'moderator') }

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end

  def password_present?
    crypted_password.present?
  end

  def promote!
    update_attribute(:role, 'admin')
  end

  def degrade!
    update_attribute(:role, 'moderator')
  end
end
