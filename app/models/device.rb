class Device < ActiveRecord::Base
  validates :app_version, presence: true

  before_create :generate_token

  def as_json(*)
    super(root: true, only: [:token])
  end

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
