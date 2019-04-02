class BikeSerializer < ActiveModel::Serializer
  attributes :id, 
	:year, 
  	:components,
   	:size, 
   	:part_number, 
   	:price, :color,
   	:manufacturer_name,
   	:rating,
   	:quantity,
   	:discipline_names

  attribute :frame_name, key: :frame
  attribute :manufacturer_name, key: :manufacturer
end
