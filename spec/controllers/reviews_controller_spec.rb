require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability_future= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
    @availability_past = Availability.create!(start_time: "2016-01-26 01:00:00", end_time: "2016-01-26 20:00:00", studio: @studio1)
    @booking_future = Booking.create(start_time: '2016-04-26 01:00:00.000000000 +0000', end_time: '2016-04-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
    @booking_past = Booking.create(start_time: '2016-01-26 01:00:00.000000000 +0000', end_time: '2016-01-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
    @review1 = Review.create(reviewable_id: @user1.id, reviewer_id: @user1.id, reviewable_type: 'User', content: '2')
    @review2 = Review.create(reviewable_id: @studio1.id, reviewer_id: @user1.id, reviewable_type: 'Studio', content: '4')
  end

  context '#new' do
    it 'creates a new review instance when passed a user id' do
      xhr :get, :new, user_id: @user1.id
      expect(assigns(:review)).to be_a Review
    end

    it 'finds the right user instance when passed an id' do
      xhr :get, :new, user_id: @user1.id
      expect(assigns(:user)).to eq @user1
    end

    it 'creates a new review instance when passed a studio id' do
      xhr :get, :new, studio_id: @studio1.id
      expect(assigns(:review)).to be_a Review
    end

    it 'finds the right studio instance when passed an id' do
      xhr :get, :new, studio_id: @studio1.id
      expect(assigns(:studio)).to eq @studio1
    end
  end

  context '#create' do
    it 'creates a new review for a user if passed a user id' do
      session[:user_id] = @user1.id
      xhr :post, :create, user_id: @user1.id, review: {content: '3'}
      expect(@user1.reviews.count).to eq 2
    end

    it 'creates a new review for a studio if passed a studio id' do
      session[:user_id] = @studio1.id
      xhr :post, :create, studio_id: @studio1.id, review: {content: '3'}
      expect(@studio1.reviews.count).to eq 2
    end

    it 'gives a flash notice if the user is not logged in' do
      xhr :post, :create, studio_id: @studio1.id, review: {content: '3'}
      expect(flash[:notice]).not_to eq nil
    end
  end
end
