require 'rails_helper'

RSpec.describe AvailabilitiesController, type: :controller do


  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability1= Availability.create!(start_time: "2016-04-05 15:42:04", end_time: "2016-04-05 18:42:04", studio: @studio1)
    @availability_future= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
    @availability_past = Availability.create!(start_time: "2016-01-26 01:00:00", end_time: "2016-01-26 20:00:00", studio: @studio1)
    @booking_future = Booking.create(start_time: '2016-04-26 01:00:00.000000000 +0000', end_time: '2016-04-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
    @booking_past = Booking.create(start_time: '2016-01-26 01:00:00.000000000 +0000', end_time: '2016-01-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
  end

  def add_availability_to_collection
    post :create, availability: {start_time: "2016-04-05 15:42:04", end_time: "2016-04-05 18:42:04"}, studio_id: @studio1.id
  end

  describe "create" do
    before { allow(controller).to receive(:current_user) {@user1}}

    it "adds an availability to a studio's collection" do
      add_availability_to_collection
      expect(Availability.last.studio).to eq(@studio1)
    end

    it 'finds the right studio based on id' do
      add_availability_to_collection
      expect(assigns(:studio)).to eq @studio1
    end

    it 'gives a 422 error if given the wrong information' do
      post :create, availability: {end_time: "2016-04-05 18:42:04"}, studio_id: @studio1.id
      expect(response).to have_http_status(422)
    end
  end

  describe '#index' do
      before { allow(controller).to receive(:current_user) {@user1}}

    it 'finds the right studio based on id' do
      get :index, studio_id: @studio1.id
      expect(assigns(:studio)).to eq @studio1
    end

    it 'adds the studio id to the session' do
      get :index, studio_id: @studio1.id
      expect(session[:studio_id]).to eq @studio1.id
    end

    it 'gives a flash notice if the studio does not exist' do
      get :index, studio_id: 4854739487383947839
      expect(flash[:danger]).to eq ['That studio does not exist']
    end

    it 'redirects to the root if the studio is not found' do
      get :index, studio_id: 4854739487383947839
      expect(response).to redirect_to '/'
    end
  end

  describe '#new' do
    before { allow(controller).to receive(:current_user) {@user1}}

    it 'finds the right studio based on id' do
      get :new, studio_id: @studio1.id
      expect(assigns(:studio)).to eq @studio1
    end

    it 'creates a new availability instance' do
      get :new, studio_id: @studio1.id
      expect(assigns(:studio)).to be_kind_of Studio
    end
  end

  describe '#get_availabilities' do

    it 'assigns the studio as the right studio' do
     session[:studio_id] = @studio1.id
     get :get_availabilities
     expect(assigns(:studio)).to eq @studio1
   end

   it 'includes the right availabilities when requested' do
     session[:studio_id] = @studio1.id
     get :get_availabilities
     expect(assigns(:availabilities)).to include @availability1
   end

   it 'finds the right bookings' do
    session[:studio_id] = @studio1.id
    get :get_availabilities
    expect(assigns(:bookings)).to include @booking_future
    expect(assigns(:bookings)).not_to include @bookings_past
    end
  end

  describe '#get_available_timeslots' do
    before { allow(controller).to receive(:current_user) {@user1}}

    it 'assigns the studio as the right studio' do
     session[:studio_id] = @studio1.id
     get :get_available_timeslots
     expect(assigns(:studio)).to eq @studio1
   end

   it 'includes the right available timeslots when requested' do
     session[:studio_id] = @studio1.id
     get :get_available_timeslots
     expect(assigns(:timeslots)).to eq [['2016-04-05 15:42:04.000000000 +0000', '2016-04-05 18:42:04.000000000 +0000', @availability1.id], ["2016-01-26 02:00:00.000000000 +0000", "2016-04-26 01:00:00.000000000 +0000", @availability_future.id], ["2016-04-26 02:00:00.000000000 +0000", "2016-04-26 20:00:00.000000000 +0000", @availability_future.id]]
   end
  end

describe '#move' do
  before { allow(controller).to receive(:current_user) {@user1}}

  it 'finds the right availability by id' do
    post :move, id: @availability1.id, minute_delta: 60, day_delta: 1
    expect(assigns(:availability)).to eq @availability1
  end
end

describe '#resize' do
  before { allow(controller).to receive(:current_user) {@user1}}


  it 'finds the right availability by id' do
    post :resize, id: @availability1.id, minute_delta: 60, day_delta: 1
    expect(assigns(:availability)).to eq @availability1
  end
end

describe '#destroy' do
  before { allow(controller).to receive(:current_user) {@user1}}

  it 'finds the right availability by id' do
    post :destroy, id: @availability1.id, studio_id: @studio1.id
    expect(assigns(:availability)).to eq @availability1
  end

  it 'finds the right availability by id' do
    post :destroy, id: @availability1.id, studio_id: @studio1.id
    expect(assigns(:studio)).to eq @studio1
  end
end
end




