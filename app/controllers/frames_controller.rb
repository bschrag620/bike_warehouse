class FramesController < ApplicationController

	def index
		if params[:user_id].nil?
			@frames = Frame.all
		else
			@frames= User.find(params[:user_id]).frames
		end
	end

	def show
		@frame = Frame.find(params[:ide])
	end

end
