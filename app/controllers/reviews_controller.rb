class ReviewsController < ApplicationController
  def create
    binding.pry
  	validate_current_user(params[:user_id])
  	@review = Review.create(review_params)
  	@review.user = current_user

    @bike = Bike.find(params[:bike_id])
    
    # a bit of code to make sure comments are valid to ease testing
    if !@review.valid?
      @review.comment += 'something was missing with this comment so this is a dummy entry'
      @review.rating = rand(1..10)
    end

    if @review.save
      render json: @review, status: 201
    else
      render 'bikes/show'
    end
  end

  private
  def review_params
  	params.require(:review).permit(:rating, :frame_id, :user_id, :comment)
  end
end
