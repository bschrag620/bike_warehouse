class BikesController < ApplicationController

	def show
		@bike = Bike.find(params[:id])
	end

	def index
		if params[:direction].nil?
			@direction = 'asc'
		elsif params[:direction] == 'asc'
			@direction = 'desc'
		else
			@direction = 'asc'
		end
		

		if !params[:manufacturer_id].nil?
			@man = Manufacturer.find(params[:manufacturer_id])
			@bikes = Bike.manufacturer_match(@man.name).where("is_available = ?", true)
		elsif !params[:discipline_id].nil?
			@discipline = Discipline.find(params[:discipline_id])
			@bikes = Bike.discipline_match(@discipline.name).where("is_available = ?", true)
		else
			@bikes = Bike.where("is_available = ?", true)
		end
	end
end
