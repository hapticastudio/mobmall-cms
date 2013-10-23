class LocalSerializer < ActiveModel::Serializer
  root false
  attributes :id, :name, :description, :poi

  def name
    object.name
  end

  def description
    object.description
  end
end
