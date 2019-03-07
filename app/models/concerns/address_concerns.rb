module AddressConcerns
	extend ActiveSupport::Concern

	included do
		def clear_address_line_2
			if !self.street_address_2.nil?
				if self.street_address_2.empty?
					self.street_address_2 = nil
				end
			end
		end

		def set_to_default
			self.class.where("user_id = ? AND NOT id = ?", self.user.id, self.id).each do |addr|
				addr.update(:default => false)
				addr.save
			end

			self.update(:default => true)
			self.save
		end
	end

	class_methods do
		def find_or_create_and_check_default(params)

			address = self.find_or_create_by(:user_id => params[:user_id], :street_address_1 => params[:street_address_1], :street_address_2 => params[:street_address_2], :city => params[:city], :state => params[:state], :zip => params[:zip])
			user = User.find_by(:id => params[:user_id])

			# if the user has selected this address to be default, then go through all the user addresses,
			# set them to false, then reset this one to true. This should help ensure
			# that we don't end up with multiple default addresses
			if params[:default] == "1" && !address.default
				address.set_to_default
			end
			address
		end
	end
end