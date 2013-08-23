class Local < ActiveRecord::Base
  include ActiveRecord::SerializerOverride
  include UpdatedSinceScope

  has_many :contents
  has_many :events
  belongs_to :moderator, class_name: "User", foreign_key: :user_id

  validates :name, presence: true, length: {maximum: 50}

  delegate :email, to: :moderator, prefix: true, allow_nil: true
  delegate :name, :name=, :description, :description=, to: :content

  def save
    contents.create(content.to_hash) if content.changed? and self.persisted?
    super
  end

  private

  def content
    @content ||= contents.confirmed.last || contents.new(confirmed: true)
  end
end
