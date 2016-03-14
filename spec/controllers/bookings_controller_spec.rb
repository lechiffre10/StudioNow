require 'rails_helper'

RSpec.describe BookingsController, type: :controller do

  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability1= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
  end

  def create_booking
    post :create, start_date: '4/26/2016', end_date: '4/26/2016', s_time: '1:00am', e_time: '2:00am', studio_id: @studio1.id, availability_id: @availability1.id, user_id: @user1.id
  end

  describe '#create' do
    before { allow(controller).to receive(:current_user) {@user1}}

    it 'creates a booking when it gets the right data and there is an available time' do
      create_booking
      expect(Booking.last.start_time).to eq('2016-04-26 01:00:00.000000000 +0000')
      expect(Booking.last.end_time).to eq('2016-04-26 02:00:00.000000000 +0000')
    end

    it 'gives the right flash notice if submitted' do
      create_booking
      expect(flash[:notice]).to eq('Your booking has been submitted.')
    end

    it 'redirects to the studio show page on submission' do
      create_booking
      expect(response).to redirect_to("/studios/#{@studio1.id}")
    end

    it 'returns flash errors if not given the right parameters' do
      post :create, start_date: '4/26/2016', end_date: '4/26/2016', s_time: '3:00am', e_time: '2:00am', studio_id: @studio1.id, availability_id: @availability1.id, user_id: @user1.id
      expect(flash[:errors]).to eq ["Your booking start date cannot be after the end date"]
    end

    it 'return correct flash errors if no suitable availability is found' do
      post :create, start_date: '4/26/2016', end_date: '4/26/2016', s_time: '12:00am', e_time: '1:00am', studio_id: @studio1.id, availability_id: @availability1.id, user_id: @user1.id
      expect(flash[:errors]).to eq ["There are no availabilities that match those requested times."]
    end
  end

end
