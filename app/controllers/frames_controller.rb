class FramesController < ApplicationController

	def index
		@frames = Frame.all
	end

	def show
		@frame = Frame.find(params[:ide])
	end

end
