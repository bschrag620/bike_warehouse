class Admin::UsersController < Admin::BaseController
	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)

		if @user.save
			redirect_to admin_users_path
		else
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :phone_number)
	end
end