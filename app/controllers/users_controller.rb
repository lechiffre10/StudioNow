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

  end

  def destroy
    session[:user_id] = nil
    render "destroy"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :description, :email, :genres)
  end


end
