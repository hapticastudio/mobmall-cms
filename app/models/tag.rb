class Tag < ActiveRecord::Base
  include UpdatedSinceScope

  has_many :taggings
  has_many :locals, through: :taggings
end
