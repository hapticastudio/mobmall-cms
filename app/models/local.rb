class Local < ActiveRecord::Base
  include ActiveRecord::SerializerOverride
  include UpdatedSinceScope

  has_many :contents
  has_many :events
  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :moderator, class_name: "User", foreign_key: :user_id

  validates :name, presence: true, length: {maximum: 50}
  validate :validate_tags

  delegate :email, to: :moderator, prefix: true, allow_nil: true
  delegate :name, :name=, :description, :description=, to: :content

  def save
    contents.create(content.to_hash) if content.changed? and self.persisted?
    super
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  private

  def validate_tags
    errors.add(:tag_list, "can't be longer than 3") if tags.length > 3
  end

  def content
    @content ||= contents.confirmed.last || contents.new(confirmed: true)
  end
end

