class BikesController < ApplicationController

	def show
		@bike = Bike.find(params[:id])
	end

	def index
		if !params[:manufacturer_id].nil?
			@man = Manufacturer.find(params[:manufacturer_id])
			@bikes = Bike.by_manufacturer(@man.name)
		else
			@bikes = Bike.unique_bikes
			
		end
	end
end
