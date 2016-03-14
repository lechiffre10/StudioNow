class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]

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

  def login
    if user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      redirect_to :back
    end
  end


  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account has been updated!"
      redirect_to @user
    else
      flash.now[:errors] = "Please fill out all fields"
      render "edit"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :description, :email, :genres, :image)
  end
end
