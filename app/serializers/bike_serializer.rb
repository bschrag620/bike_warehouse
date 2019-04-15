class BikeSerializer < ActiveModel::Serializer
  attributes :id, :year, :components, :size, :part_number, :price, :color, :rating, :quantity

  attribute :frame_name, key: :frame
  attribute :manufacturer_name, key: :manufacturer

  has_many :reviews
  has_many :disciplines
end
