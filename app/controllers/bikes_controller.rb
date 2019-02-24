class BikesController < ApplicationController
	def new
		@bike = Bike.new
	end

	def create
		@bike = Bike.create(bike_params)
		@bike.set_serial
		if !discipline_params[:names].nil?
			@bike.discipline_ids += Discipline.mass_create(discipline_params[:names])
		end
		@bike.save
		redirect_to bike_path(@bike)
	end

	def show
		@bike = Bike.find(params[:id])
	end

	def edit

	end

	def update

	end

	def destroy

	end

	private
	def bike_params
		params.require(:bike)
			.permit(
			:manufacturer, :frame, :components, 
			:color, :serial, :year, :price, discipline_ids:[])
	end

	def discipline_params
		params.require(:discipline).permit(:names)
	end
end
