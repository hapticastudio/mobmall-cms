class TagSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name

  has_many :locals, embed: :ids
end
