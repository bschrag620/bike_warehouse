class Admin::BaseController < ApplicationController
	layout 'layouts/admin/application'

	before_action :authorized_user?

	def index
		
	end

	def inventory

	end

	def new
		@manufacturers = Manufacturer.all
		@frames = Frame.all
	end

	private
	def authorized_user?
		if !is_admin?
			flash[:message] = "Requires login and admin privelages."
			redirect_to root_path
		end
	end
end