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
		@bikes = Bike.unique_bikes
		respond_to do |format|
			format.html
			format.json { render :json => @bikes, status: 200 }
		end
	end
end
