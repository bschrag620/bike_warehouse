class BikesController < ApplicationController

	def show
		@bike = Bike.find(params[:id])
		@review = @bike.frame.reviews.build
	end

	def index
		direction = params[:direction] || 'asc'
		@category = params[:category] || 'manufacturer'
		
		if !params[:manufacturer_id].nil?
			@man = Manufacturer.find(params[:manufacturer_id])
			@bikes = Bike.manufacturer_match(@man.name)
		elsif !params[:discipline_id].nil?
			@discipline = Discipline.find(params[:discipline_id])
			@bikes = Bike.discipline_match(@discipline.name)
		else
			@bikes = Bike.unique_bikes
		end

		@direction = direction == 'asc' ? 'desc' : 'asc'
		
		@bikes = @bikes.ordered_by(@category, direction)
	end
end
