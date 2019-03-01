class ApplicationController < ActionController::Base
	include CustomRedirect
	helper_method :current_user, :logged_in?, :is_admin?, :cart, :cart_lookup, :cart_qty, :cart, :cart_lookup, :cart_total

	# helpers for user authentication
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

	# helpers for shopping cart
	def cart
		session[:cart] ||= []
	end

	def cart_qty
		if session[:cart].nil?
			0
		else
			session[:cart].count
		end
	end

	def cart_total
		total = 0
		cart_lookup.each do |item|
			total += item.price
		end
		total
	end

	def cart_lookup
		cart.collect do |item_id|
			Bike.find(item_id)
		end
	end
end
