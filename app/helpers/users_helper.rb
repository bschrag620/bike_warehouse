module UsersHelper

	def is_shipping?(address)
		address.class.name == "ShippingAddress"
	end

	def shipping_edit_button(address)
		if is_shipping?(address)
			button_to("Edit", edit_user_shipping_address_path(address.user, address))
		else
			button_to("Edit", edit_user_billing_address_path(address.user, address))
		end
	end
end