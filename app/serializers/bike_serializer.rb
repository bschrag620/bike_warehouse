class BikeSerializer < ActiveModel::Serializer
  attributes :id, 
	:year, 
  	:components,
   	:size, 
   	:part_number, 
   	:price, :color,
   	:manufacturer_name,
   	:frame_name,
   	:rating,
   	:quantity,
   	:discipline_names
end
