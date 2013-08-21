class Local < ActiveRecord::Base
  has_many   :contents
  belongs_to :moderator, class_name: "User", foreign_key: :user_id

  validates :name, presence: true, length: {maximum: 50}

  delegate :email, to: :moderator, prefix: true, allow_nil: true

  def name
    content.name
  end

  def name=(name)
    content.name = name
  end

  def description
    content.description
  end

  def description=(description)
    content.description = description
  end

  def save
    contents.create(content.to_hash) if content.changed? and self.persisted?
    super
  end

  private

  def content
    @content ||= contents.last || contents.new
  end
end
