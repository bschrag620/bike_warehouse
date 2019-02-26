class FramesController < ApplicationController
	include CustomRedirect

	def destroy
		@frame = Frame.find(params[:id])
		
		if !params[:redirect].empty?
			set_redirect(params[:redirect])
		end
		

		if @frame.total_count == 0
			flash[:message] = "#{frame.name} removed from database."
			frame.destroy
			if redirect?
				clear_redirect
			else
				redirect_to manufacturers_path
			end
		else
			@frame.errors.add("There are bikes in the database associated with this frame. It can not be deleted at this time.")
			redirect_to frame_path(@frame)
		end
	end

	def new
		@frame = Frame.new
	end

	def edit
		if !params[:redirect].empty?
			set_redirect(params[:redirect])
		end
		binding.pry
	end

	def update


		if redirect?
				clear_redirect
			else
				redirect_to manufacturers_path
			end
	end


	def index
		@frames = Frame.all
	end

	def create
		@frame = Frame.new(frame_params)
		if !params[:discipline][:names].empty?
			Discipline.mass_create(params[:discipline][:names])
		end

		if @frame.save
			redirect_to frame_path(@frame)
		else
			render :new
		end
	end

	def show
		@frame = Frame.find(params[:ide])
	end

	private
	def frame_params
		params.require(:frame).permit(:name, :manufacturer_id)
	end	

	def discipline_params
		params.require(:discipline).permit(:names)
	end
end
