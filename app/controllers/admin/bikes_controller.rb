class Admin::BikesController < ApplicationController
	def new
		@bike = Bike.new
	end

	def create
		@bike = Bike.create(bike_params)
		@bike.set_serial
		
		if @bike.save
			binding.pry
			redirect_to admin_bike_path(@bike)
		else
			binding.pry
			render :new
		end
	end

	def show
		@bike = Bike.find(params[:id])
	end

	def index(sort_by: nil)
		if !params[:sort_by].nil?
			category = params[:sort_by].split('_')[0]
			direction = params[:sort_by].split('_')[1]

			@bikes = Bike.order_by(category, direction)
			if direction == "asc"
				@direction = "desc"
			else
				@direction = "asc"
			end
		else
			@bikes = Bike.all
			@direction = "asc"
		end
	end


	def edit
		@bike = Bike.find(params[:id])
	end

	def update
		@bike = Bike.find(params[:id])
		@bike.update(bike_params)
		if @bike.save
			redirect_to admin_bike_path(@bike)
		else
			render :edit
		end
	end

	def destroy

	end

	private
	def bike_params
		params.require(:bike)
			.permit(
				:frame_id, :components, 
				:color, :serial, :year, 
				:price, discipline_ids:[])
	end
end
