module BikesHelper
	
	def render_autocomplete(symbol, field)
		render 'partials/autocomplete', category: symbol, f: field
	end

	def sort_by_link(category, direction)
		current_path = request.original_fullpath
		base_path = current_path.split('/sort')[0]
		link_to category.capitalize, "#{base_path}/sort/#{category}/#{direction}"
	end

	def button_for_cart_or_edit(bike)
		if is_admin?
			link_to "Edit", edit_admin_bike_path(bike)
		else
			render 'session/add_to_cart_with_qty', qty: bike.qty_available, part_number: bike.part_number
		end
	end

	def status(bike)
		if bike.status == "Sold"
			link_to "Sold", (admin_purchase_path(bike.purchase.id))
		else
			bike.status
		end
	end

	def render_reviews(bike)
		if bike.frame.reviews.count > 0
			render 'partials/reviews', reviews: bike.frame.reviews[0..-2]
		else
			"No reviews. Be the first to leave a review!"
		end
	end

	def render_review_form(review)
		if logged_in? && !is_admin?
			render 'partials/review_form', review: review
		elsif !is_admin?
			render 'partials/login_to_review'
		end
	end
end