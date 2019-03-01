class UsersController < SessionController
	def new
		@user = User.new
		render 'session/signup'
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session_login(@user)
			redirect_to root_path
		else
			render 'session/signup'
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :email, :phone_number, :is_admin)
	end
end