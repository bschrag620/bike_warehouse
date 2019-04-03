class DisciplineSerializer < ActiveModel::Serializer
  attributes :name
  belongs_to :bike
end
