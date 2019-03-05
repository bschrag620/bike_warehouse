class SessionController < ApplicationController
	helper_method :add_to_cart, :cart, :cart_total, :cart_lookup, :cart_qty


	def index

	end

	def login

	end

	def signup
		if logged_in?
			redirect_to root_path
		end
		@user = User.new
	end

	def validate
		if params[:redirect_path] != '/login'
			set_redirect(params[:redirect_path])
		else
			set_redirect(root_path)
		end
		user = User.find_by(:username => params[:username])
		
		if user && user.authenticate(params[:password_digest])
			session_login(user)
			if is_admin?
				redirect_to admin_path
			else
				clear_redirect
			end
		else
			redirect_to login_path
		end
	end

	def logout
		session_logout
		clear_cart
		redirect_to root_path
	end

	def session_login(user)
		session[:user_id] = user.id
	end

	def session_logout
		session.delete(:user_id)
	end

	def add_to_cart
		params[:qty].to_i.times do |i|
			bike =  Bike.find_by(:part_number => params[:part_number])
			bike.mark_in_cart
			cart << bike.id
		end
		
		session[:cart] = cart

		redirect_to cart_path
	end

	def shopping_cart

	end
end
