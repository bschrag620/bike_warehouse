module ApplicationHelper
	def label_text(symbol, f)
		render 'partials/label_text', sym: symbol, f: f
	end

	def autocomplete(symbol, f)
		render 'partials/autocomplete', category: symbol, f:f
	end

	def is_admin?
		true
	end

	def choose_link(path)
		if is_admin?
			"/admin#{path}"
		else
			path
		end
	end
end
