module BikeHelper
	
	def render_autocomplete(symbol, field)
		render 'partials/autocomplete', category: symbol, f: field
	end
end