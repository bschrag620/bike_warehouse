module AddressConcerns
	extend ActiveSupport::Concern

	class_methods do
		def find_or_create_and_check_default(params)

			address = self.find_or_create_by(:user_id => params[:user_id], :street_address_1 => params[:street_address_1], :street_address_2 => params[:street_address_2], :city => params[:city], :state => params[:state], :zip => params[:zip])
			user = User.find_by(:id => params[:user_id])

			# if the user has selected this address to be default, then go through all the user addresses,
			# set them to false, then reset this one to true. This should help ensure
			# that we don't end up with multiple default addresses
			if params[:default] == "1" && !address.default
				self.where("user_id = ? AND NOT id = ?", user.id, address.id).each do |addr|
					addr.update(:default => false)
					addr.save
				end
				address.update(:default => true)
				address.save
			end
			address
		end
	end
end