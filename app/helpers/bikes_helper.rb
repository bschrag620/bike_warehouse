module BikesHelper
	
	def render_autocomplete(symbol, field)
		render 'partials/autocomplete', category: symbol, f: field
	end

	def sort_by_link(category, direction)
		render 'bikes/sort_by', category: category, direction: direction
	end
end