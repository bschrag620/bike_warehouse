module ApplicationHelper
	def label_text(symbol, f)
		render 'partials/label_text', sym: symbol, f: f
	end

	def label_password(symbol, f)
		render 'partials/label_password', sym: symbol, f: f
	end

	def autocomplete(symbol, f)
		render 'partials/autocomplete', category: symbol, f:f
	end

	def render_errors(obj)
		render 'partials/errors', obj: obj
	end

	def logout_link
		render '/session/logout'
	end

	def choose_link(path)
		if is_admin?
			"/admin#{path}"
		else
			path
		end
	end
end
