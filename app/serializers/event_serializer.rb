class EventSerializer < ActiveModel::Serializer
  root false
  attributes :id, :local_id, :description, :begin_time, :end_time
end
