class PurchasesController < ApplicationController
	def new
		@user = current_user
		@user.shipping_addresses.build
		@user.billing_addresses.build
	end
end