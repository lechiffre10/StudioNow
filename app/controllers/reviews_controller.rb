class ReviewsController < ApplicationController

  def new
    @review = Review.new
    params[:user_id].nil? ? @studio = Studio.find(params[:studio_id]) : @user = User.find(params[:user_id])
  end

  def create
    params[:user_id].nil? ? this = Studio.find(params[:studio_id]) : this = User.find(params[:user_id])
    @review = this.reviews.new(review_params)
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
