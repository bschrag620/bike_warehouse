class PurchasesController < ApplicationController
	def new
		user = current_user
		@purchase = user.purchases.build(:shipping_address => user.default_shipping, :billing_address => user.default_billing)
	end

	def create
		@purchase = Purchase.create(purchase_params)

		if params[:billing_address][:same_as_shipping] == "1"
				params[:purchase][:billing_address] = params[:purchase][:shipping_address]
		end

		@purchase.shipping_address = ShippingAddress.find_or_create_and_check_default(shipping_address_params)
		@purchase.billing_address = BillingAddress.find_or_create_and_check_default(billing_address_params)

		if @purchase.save
			redirect_to edit_purchase_path(@purchase)
		else
			render 'purchases/new'
		end
	end

	def edit
		@purchase = Purchase.find(params[:id])
	end

	def update
		@purchase = Purchase.find(params[:id])

		if params[:purchase][:cc_number].empty?
			@purchase.errors.add(:cc_number, "cannot be blank.")
			render :edit
		else
			@purchase.update(cc_params)
		end

		if @purchase.save
			cart.each do |bike_id|
				bike = Bike.find(bike_id)
				bike.mark_as_sold(@purchase.id)
			end

			@purchase.mark_as_complete(cart_total, tax(cart_total))
			clear_cart
			redirect_to receipt_path(@purchase)
		else
			render :edit
		end
	end

	def receipt
		@purchase = Purchase.find(params[:id])

	end

	private
		def purchase_params
			params.require(:purchase).permit(
				:user_id)
		end

		def shipping_address_params
			params.require(:purchase).require(:shipping_address).permit(
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip,
				:default)
		end

		def billing_address_params
			params.require(:purchase).require(:billing_address).permit(
				:user_id,
				:street_address_1,
				:street_address_2,
				:city,
				:state,
				:zip,
				:default)
		end

		def cc_params
			params.require(:purchase).permit(:cc_number)
		end

end