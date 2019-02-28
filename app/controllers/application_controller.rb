class ApplicationController < ActionController::Base
	include CustomRedirect
	helper_method :current_user, :logged_in?, :is_admin?


	def current_user
		User.find(session[:user_id])
	end

	def logged_in?
		!!session[:user_id]
	end

	def is_admin?
	true
	# current_user.is_admin?
	end

end
