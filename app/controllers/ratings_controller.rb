class RatingsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @review = Review.new
    puts "hello!!!"
  end

  def create
  end
end
