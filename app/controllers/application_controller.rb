class ApplicationController < ActionController::Base
	include CustomRedirect
	helper_method :current_user, :logged_in?, :is_admin?, :cart, :cart_lookup, :cart_qty, :cart, :cart_lookup, :cart_total, :tax

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

	def clear_cart
		cart.each do |item_id|
			bike = Bike.find_by(:id => item_id)
			if bike.in_cart
				bike.mark_available
			end
		end
		session.delete(:cart)
	end	

	def tax(value)
		0.0975 * value
	end

	def validate_current_user(id)
		if logged_in? 
			if current_user.id.to_s != id
				flash[:message] = "Unauthorized access."
				redirect_to root_path
			end
		else
			flash[:message] = "Requires login to access."
			redirect_to login_path
		end
	end
end
