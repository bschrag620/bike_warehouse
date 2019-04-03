class DisciplineSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :bike
end
