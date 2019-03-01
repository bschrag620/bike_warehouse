class TransactionsController < ApplicationController
	def checkout
		@user = current_user
		@shipping_address = @user.default_shipping
		@billing_address = @user.default_billing
	end
end