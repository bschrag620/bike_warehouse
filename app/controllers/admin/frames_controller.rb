class Admin::FramesController < Admin::BaseController

	def destroy
		@frame = Frame.find(params[:id])
		
		if !params[:redirect].nil?
			set_redirect(params[:redirect])
		end

		if @frame
			flash_destroy(@frame.name)
			@frame.destroy
			if redirect?
				redirect_to clear_redirect
			else
				redirect_to admin_frames_path
			end
		else
			flash_custom("There are bikes in the database associated with this frame. It can not be deleted at this time.")
			redirect_to admin_frames_path
		end
	end

	def new
		@frame = Frame.new
	end

	def edit
		session.delete(:redirect)

		if !params[:redirect].nil?
			set_redirect(params[:redirect])
			params.delete(:redirect)
		end

		@frame = Frame.find(params[:id])
	end

	def update
		@frame = Frame.find(params[:id])
		@frame.update(frame_params)

		if @frame.save
			flash_update(@frame.name)
			if redirect?
					redirect_to clear_redirect
				else
					redirect_to admin_frames_path
			end
		else
			render :edit
		end
	end


	def index
		@frames = Frame.all

		render '/frames/index'
	end

	def create
		@frame = Frame.new(frame_params)
		if !params[:discipline][:names].empty?
			Discipline.mass_create(params[:discipline][:names])
		end

		if @frame.save
			flash_create(@flash)
			redirect_to frame_path(@frame)
		else
			render :new
		end
	end

	private
	def frame_params
		params.require(:frame).permit(:name, :manufacturer_id, :discipline_ids => [])
	end	

	def discipline_params
		params.require(:discipline).permit(:names)
	end
end
