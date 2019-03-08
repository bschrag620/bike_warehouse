class ReviewsController < ApplicationController
  def create
  	validate_current_user(params[:user_id])
  	@review = Review.create(review_params)
  	@review.user = current_user
  	
  	if @review.save
		redirect_to bike_path(@review.bike)
	else
		@bike = @review.bike
		render 'bikes/show'
	end
  end

  private
  def review_params
  	params.require(:review).permit(:rating, :bike_id, :user_id, :comment)
  end
end
