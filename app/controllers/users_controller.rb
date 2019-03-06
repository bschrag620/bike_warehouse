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

	def update
		validate_current_user(params[:user_id])
		@user = current_user

		if params.keys.include?("checkout_in_process")
			PurchasesControler::create(params)
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