class ReviewsController < ApplicationController
  def create
  	validate_current_user(params[:user_id])
  	@review = Review.create(review_params)
  	@review.user = current_user
  	@review.save

  	redirect_to bike_path(@review.bike)
  end

  private
  def review_params
  	params.require(:review).permit(:rating, :bike_id, :user_id, :comment)
  end
end
