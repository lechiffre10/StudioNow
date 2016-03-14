class ReviewsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    if session[:user_id].nil?
      flash[:notice] = "You cannot make a review without being logged in bro!"
    else
      @review[:reviewer_id] = session[:user_id]
      @review.save
    end
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
