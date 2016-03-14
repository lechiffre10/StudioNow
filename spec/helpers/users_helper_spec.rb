require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @user2= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
  end

  context '#current_user' do
    it 'finds the right user based on session' do
      session[:user_id] = @user1.id
      expect(current_user).to eq @user1
    end
  end

  context '#logged_in?' do
    it 'returns true if a user is logged in' do
      session[:user_id] = @user1.id
      expect(logged_in?).to be true
    end

    it 'returns true if a user is logged in' do
      expect(logged_in?).to be false
    end
  end

  context 'session_user' do
    it 'returns true if a user is logged in is the same as the user with params' do
      params[:id] = @user1.id
      session[:user_id] = @user1.id
      expect(session_user?).to be true
    end

  end

end
