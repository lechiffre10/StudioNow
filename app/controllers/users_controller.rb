class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      redirect_to :back
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update

  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :description, :email, :genres)
  end


end
