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
			render 'session/add_to_cart_with_qty', qty: bike.qty_available, part_number: bike.part_number
		end
	end
end