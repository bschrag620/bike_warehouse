class ReviewsController < ApplicationController
  def create
  	validate_current_user(params[:user_id])
  	@review = Review.create(review_params)
  	@review.user = current_user
    @bike = Bike.find(params[:bike_id])

    if @review.save
      redirect_to bike_path(@bike)
    else
      render 'bikes/show'
    end
  end

  private
  def review_params
  	params.require(:review).permit(:rating, :frame_id, :user_id, :comment)
  end
end
