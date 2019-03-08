class BikesController < ApplicationController

	def show
		@bike = Bike.find(params[:id])
	end

	def index
		if params[:direction].nil?
			direction = 'asc'
		else
			direction = params[:direction]
		end
		if params[:category].nil?
			@category = "manufacturer"
		else
			@category = params[:category]
		end
		
		if !params[:manufacturer_id].nil?
			@man = Manufacturer.find(params[:manufacturer_id])
			@bikes = Bike.manufacturer_match(@man.name)
		elsif !params[:discipline_id].nil?
			@discipline = Discipline.find(params[:discipline_id])
			@bikes = Bike.discipline_match(@discipline.name)
		else
			@bikes = Bike.unique_bikes
		end

		if direction == 'asc'
			@direction = 'desc'
		else
			@direction = 'asc'
		end

		@bikes = @bikes.ordered_by(@category, direction)
	end
end
