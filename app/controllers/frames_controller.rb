class FramesController < ApplicationController
	include CustomRedirect

	def index
		@frames = Frame.all
	end

	def show
		@frame = Frame.find(params[:ide])
	end

end
