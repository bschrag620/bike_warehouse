class ApplicationController < ActionController::Base
	include CustomRedirect
	helper_method :current_user, :logged_in?, :is_admin?, :cart, :cart_lookup


	def current_user
		User.find_by(:id => session[:user_id])
	end

	def logged_in?
		!!session[:user_id]
	end

	def is_admin?
		if logged_in?
			current_user.is_admin?
		else
			false
		end
	end

	def logout
		session.delete(:user_id)
	end

end
