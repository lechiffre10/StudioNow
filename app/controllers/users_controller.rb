class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create

  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update

  end

  def destroy

  end


end
