class Admin::BikesController < Admin::BaseController

	def new
		if !params[:manufacturer_id].nil?
			@bike = Bike.new
			@manufacturers = [Manufacturer.find(params[:manufacturer_id])]
		elsif !params[:frame_id].nil?
			frame = Frame.find(params[:frame_id])
			@bike = frame.bikes.build
			@manufacturers = [@bike.manufacturer]
		else
			@manufacturers = Manufacturer.all
			@bike = Bike.new
		end
	end	

	def create
		@bike = Bike.create(bike_params)
		binding.pry
		@bike.set_serial
		
		if @bike.save
			redirect_to admin_bike_path(@bike)
		else
			@manufacturers = Manufacturer.all
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
				:price, :size, discipline_ids:[])
	end
end
