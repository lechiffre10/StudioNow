class RatingsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
  end
end
