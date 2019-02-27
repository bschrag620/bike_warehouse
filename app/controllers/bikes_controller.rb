class BikesController < ApplicationController

	helper BikesHelper

	def show
		@bike = Bike.find(params[:id])
	end

	def index(sort_by: nil)
		#if !params[:sort_by].nil?
		#	category = params[:sort_by].split('_')[0]
		#	direction = params[:sort_by].split('_')[1]
#
#			@bikes = Bike.order_by(category, direction)
#			if direction == "asc"
#				@direction = "desc"
#			else
#				@direction = "asc"
#			end
#		else
#			@bikes = Bike.all
#			@direction = "asc"
#		end
		@bikes = Bike.all
	end
end
