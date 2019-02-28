class SessionController < ApplicationController
	def index

	end

	def login

	end

	def signup
		@user = User.new
	end

	def validate
		binding.pry
		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session_login(user)
			if is_admin?
				redirect_to admin_path
			else
				redirect_to root_path
			end
		else
			redirect_to login_path
		end
	end

	def logout
		session.delete(:user_id)
		redirect_to root_path
	end

	def session_login(user)
		session[:user_id] = user.id
	end
end
