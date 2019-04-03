class BikesController < ApplicationController

	def show
		@bike = Bike.find(params[:id])
		@review = @bike.frame.reviews.build

		respond_to do |format|
			format.html
			format.json { render :json => @bike }
		end	
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

		@bikes = @bikes.ordered_by(@category, direction)
		respond_to do |format|
			format.html
			format.json { render :json => @bikes, status: 200 }
		end
	end
end
