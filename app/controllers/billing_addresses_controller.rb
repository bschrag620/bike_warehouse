class BillingAddressesController < ApplicationController
	def edit
		validate_current_user(params[:user_id])

		@address = BillingAddress.find(params[:id])
	end

	def update
		validate_current_user(params[:user_id])

		@address = BillingAddress.find(params[:id])
		@address.update(billing_address_params)

		if params[:billing_address][:default] == "1"
			@address.set_to_default
		end

		if @address.save
			flash[:message] = "Address successfully update."
			redirect_to user_path(@address.user)
		else
			render :edit
		end
	end

	def destroy
		validate_current_user(params[:user_id])

		@address = ShippingAddress.find(params[:id])
		@address.destroy

		flash[:message] = "Address successfully deleted."

		redirect_to user_path(@address.user)
	end	

	private
	def billing_address_params
		params.require(:billing_address).permit(:street_address_1, :street_address_2, :city, :state, :zip)
	end
end