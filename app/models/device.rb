class Device < ActiveRecord::Base
  validates :app_version, presence: true

  before_create :generate_token
  before_create :generate_last_request_at

  def as_json(*)
    super(root: true, only: [:token])
  end

  def update_last_request_at!
    update_attributes(last_request_at: time_now)
  end

  private

  def time_now
    -> { Time.now }.call
  end

  def generate_last_request_at
    self.last_request_at = time_now
  end

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
