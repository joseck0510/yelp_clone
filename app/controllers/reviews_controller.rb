class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # @review = @restaurant.build_review(review_params, current_user)
    if current_user.has_reviewed? @restaurant
      flash[:notice] = "You can only review a restaurant once"
    else
      @restaurant.reviews.create(review_params)
    end
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
