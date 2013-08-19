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

  private

  def content
    contents.last || contents.new
  end
end
