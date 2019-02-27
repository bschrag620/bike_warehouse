class ManufacturersController < ApplicationController

	include CustomRedirect

	def show
		@man = Manufacturer.find(params[:id])
	end

	def index
		@manufacturers = Manufacturer.all
	end

	
end