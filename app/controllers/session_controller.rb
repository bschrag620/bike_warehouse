class SessionController < ApplicationController
	helper_method :add_to_cart, :cart, :cart_total, :cart_lookup

	def index

	end

	def login

	end

	def signup
		@user = User.new
	end

	def validate
		if params[:redirect_path] != '/login'
			set_redirect(params[:redirect_path])
		else
			set_redirect(root_path)
		end
		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session_login(user)
			if is_admin?
				redirect_to admin_root_path
			else
				clear_redirect
			end
		else
			redirect_to login_path
		end
	end

	def logout
		session.delete(:user_id)
		session.delete(:cart)
		redirect_to root_path
	end

	def session_login(user)
		session[:user_id] = user.id
	end

	def sanitize_cart
		cart.each do |item|
			if item.nil?
				cart.delete(item)
			end
		end
		session[:cart] = cart
	end

	def add_to_cart
		binding.pry
		cart << params[:product_id]
		session[:cart] = cart

		sanitize_cart

		redirect_to cart_path
	end

	def cart_total
		total = 0
		cart_lookup.each do |item|
			total += item.price
		end
		total
	end

	def shopping_cart

	end

	def cart_lookup
		cart.collect do |item_id|
			Bike.find(item_id)
		end
	end

	def cart
		session[:cart] ||= []
	end
end
