class Admin::ManufacturersController < Admin::BaseController

	def show
		@man = Manufacturer.find(params[:id])
	end

	def index
		@manufacturers = Manufacturer.all

		render 'manufacturers/index'
	end

	def edit
		@man = Manufacturer.find(params[:id])
	end

	def new
		if !params[:redirect].nil?
			set_redirect(params[:redirect])
		end
		@man = Manufacturer.new
	end

	def create
		@man = Manufacturer.new(manufacturer_params)

		frame_name_params.split(',').each do |name|
			new_frame = @man.frames.build(:name => name.strip)
			new_frame.save
		end

		if @man.save
			if redirect?
				redirect_to clear_redirect
			else
				redirect_to admin_manufacturers_path
			end
		else
			render :new
		end
	end

	def update
		@man = Manufacturer.find(params[:id])
		params[:manufacturer][:frame_ids] += @man.frame_ids
		@man.update(manufacturer_params)
		if @man.save
			redirect_to admin_manufacturer_path(@man)
		else
			render :edit
		end
	end

	def destroy
		@man = Manufacturer.find(params[:id])
		flash[:message] = "#{@man.name} has been deleted."
		@man.destroy

		redirect_to admin_manufacturers_path
	end

	private
	def manufacturer_params
		params.require(:manufacturer).permit(:name, frame_ids:[])	
	end

	def frame_name_params
		params.require(:frame_names)
	end

end