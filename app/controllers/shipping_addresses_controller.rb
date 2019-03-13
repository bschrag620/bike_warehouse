class ShippingAddressesController < ApplicationController
	
	def edit
		validate_current_user(params[:user_id])

		@address = ShippingAddress.find(params[:id])
	end

	def update
		validate_current_user(params[:user_id])

		@address = ShippingAddress.find(params[:id])
		@address.update(shipping_address_params)

		if params[:shipping_address][:default] == "1"
			@address.set_to_default
		end

		if @address.save
			flash_update("Shipping address successfully")
			redirect_to user_path(@address.user)
		else
			render :edit
		end
	end

	def destroy
		validate_current_user(params[:user_id])

		@address = ShippingAddress.find(params[:id])
		@address.destroy

		flash_destroy("Shipping address")

		redirect_to user_path(@address.user)
	end	

	private
	def shipping_address_params
		params.require(:shipping_address).permit(:street_address_1, :street_address_2, :city, :state, :zip)
	end
end