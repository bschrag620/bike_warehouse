class BikeSerializer < ActiveModel::Serializer
  attributes :id, :year, :components, :size, :part_number, :price, :color
end
