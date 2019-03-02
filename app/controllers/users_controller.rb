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
		@user = current_user
		binding.pry
		if params.keys.include?(:redirect)
			if params[:billing_address][:same_as_shipping]
				params[:user][:billing_address] = params[:user][:shipping_address]
			end
			@shipping_address = ShippingAddress.find_or_create_by(shipping_address_params[:shipping_address])
			@billing_address = BillingAddress.find_or_create_by(billing_address_params[:billing_address])
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :email, :phone_number, :is_admin)
	end

	def shipping_address_params
		params.require(:user).permit(
			shipping_address: [
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip])
	end

	def billing_address_params
		params.require(:user).permit(
			billing_address: [
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip])
	end
end