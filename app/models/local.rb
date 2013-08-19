class Local < ActiveRecord::Base
  has_many   :contents
  belongs_to :user

  validates_length_of :name, maximum: 50

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
