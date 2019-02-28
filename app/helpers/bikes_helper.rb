module BikesHelper
	
	def render_autocomplete(symbol, field)
		render 'partials/autocomplete', category: symbol, f: field
	end

	def sort_by_link(category, direction)
		render 'bikes/sort_by', category: category, direction: direction
	end

	def button_for_cart_or_edit(bike)
		if is_admin?
			link_to "Edit", edit_admin_bike_path(bike)
		else
			button_to("Add to cart", add_to_cart_path(:product_id => bike.id))
		end
	end
end