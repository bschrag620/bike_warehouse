module SessionHelper
	def link_to_cart(cart_qty)
		render 'session/link_to_cart', qty: cart_qty
	end	
end