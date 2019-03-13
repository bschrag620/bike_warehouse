class Admin::PurchasesController < Admin::BaseController
	def index
		if !params[:user_id].nil?
			@user = User.find(params[:user_id])
			@purchases = @user.purchases
		else
			@purchases = Purchase.all
		end
	end	

	def show
		@purchase = Purchase.find(params[:id])
	end

	def destroy
		@purchase = Purchase.find(params[:id])
		flash_destroy("Transaction #{@purchase.purchase_id}")
		@purchase.destroy
		redirect_to admin_purchases_path
	end
end