class Admin::BikesController < Admin::BaseController

	def new
		@bike = Bike.new
	end

	def create
		@bike = Bike.create(bike_params)
		@bike.set_serial
		
		if @bike.save
			redirect_to admin_bike_path(@bike)
		else
			binding.pry
			render :new
		end
	end

	def show
		@bike = Bike.find(params[:id])
		render 'bikes/show'
	end

	def index
		if !params[:manufacturer_id].nil?
			@man = Manufacturer.find(params[:manufacturer_id])
			@bikes = Bike.manufacturer_match(@man.name)
		elsif !params[:discipline_id].nil?
			@discipline = Discipline.find(params[:discipline_id])
			@bikes = Bike.discipline_match(@discipline.name)
		else
			@bikes = Bike.all
		end

		render 'bikes/index'
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
