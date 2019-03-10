class SessionController < ApplicationController
	helper_method :add_to_cart, :cart, :cart_total, :cart_lookup, :cart_qty

	def create
		@user = User.find_or_create_by(:facebook_uid => auth['uid'])

		if !@user.valid?
			@user.username = auth[:info][:name]
			@user.email = auth[:info][:email]
			@user.password_digest = BCrypt::Password.create(auth[:credentials][:token])
			@user.password_digest_confirmation = BCrypt::Password.create(auth[:credentials][:token])
			@user.save
		end
		session_login(@user)

		redirect_to root_path
	end

	def index

	end

	def login
		if logged_in?
			flash[:message] = "Already logged in."
			redirect_to root_path
		end
	end

	def signup
		if logged_in?
			flash[:message] = "Already logged in."
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
				redirect_to clear_redirect
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
			bike =  Bike.find_available(params[:part_number])
			bike.mark_in_cart
			cart << bike.id.to_s
		end
		
		session[:cart] = cart

		redirect_to cart_path
	end

	def shopping_cart

	end

	def remove_item
		bike = Bike.find(cart.delete(params[:id]))
		bike.mark_available
		redirect_to cart_path
	end

	private
	def auth
		request.env['omniauth.auth']
	end
end
