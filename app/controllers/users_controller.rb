class UsersController < SessionController
	
	def new
		@user = User.new
		render 'session/signup'
	end

	def create
		@user = User.new(user_params)

		if !@user.save
			render 'session/signup'
		end

		session_login(@user)
		redirect_to root_path
	end

	def update
		validate_current_user(params[:user_id] || params[:id])
		@user = current_user

		@user.update(user_params)
		if @user.save
			flash[:message] = "Profile successfully updated."
			redirect_to user_path(@user)
		else
			flash[:message] = "Profile could not be updated."
			render :edit
		end
	end

	def show
		validate_current_user(params[:id])
		@user = current_user
	end

	def edit
		validate_current_user(params[:id])
		@user = current_user
	end

	private
	def user_params
		params.require(:user).permit(:username, :password_digest, :password_digest_confirmation, :email, :phone_number, :is_admin)
	end

	def shipping_address_params
		params.require(:user).permit(
			shipping_address: [
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip,
				:default])
	end

	def billing_address_params
		params.require(:user).permit(
			billing_address: [
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip,
				:default])
	end
end