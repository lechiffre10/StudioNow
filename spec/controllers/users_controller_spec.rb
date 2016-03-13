require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @user = User.create(first_name: 'ray', last_name: 'curran', username: 'tyler', password: 'password', email: 'dbc@dbc.com')
  end

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'users#create' do
    it 'increases the count of users when passed the right information' do
      number_of_users = User.count
      post :create, user: {first_name: 'Tyler', last_name: 'Mac', username: 'tytyty', password: 'password', email: 'tyler@tyler.com'}
      expect(User.count).to eq(number_of_users + 1)
    end

    it 'redirects back to the same page if not passed the right info' do
      post :create, user: {username: 'arg', password: 'veee'}
      expect(response).to redirect_to('where_i_came_from')
    end
  end

  describe '#new' do
    it 'creates a new user instance' do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe '#show' do
    it 'shows the correct user' do
      get :show, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end

    it 'goes to the show page when a user id is found' do
      get :show, id: @user.id
      expect(response).to render_template(:show)
    end
  end

  describe '#edit' do
    it 'finds the right user' do
      get :edit, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end

    it 'goes to the edit page when a user id is found' do
      get :edit, id: @user.id
      expect(response).to render_template(:edit)
    end
  end

  describe '#login' do
    it 'redirects to the user show page on successful login' do
      post :login, user: { username: @user.username, password: @user.password}
      correct_url = '/users/' + @user.id.to_s
      expect(response).to redirect_to(correct_url)
    end

    it 'adds the user id to the session on successful login' do
      post :login, user: { username: @user.username, password: @user.password}
      expect(session[:user_id]).to eq(@user.id)
    end

    it 'redirects back to the same page if not passed the right info' do
      post :login, user: {username: 'arg', password: 'veee'}
      expect(response).to redirect_to('where_i_came_from')
    end
  end

  describe '#destroy' do
    it 'removes the session when logged out' do
      post :login, user: { username: @user.username, password: @user.password}
      delete :destroy
      expect(session[:user_id]).to eq(nil)
    end

    it 'renders the destroy page when logged out' do
      delete :destroy
      expect(response).to redirect_to '/'
    end
  end
end
