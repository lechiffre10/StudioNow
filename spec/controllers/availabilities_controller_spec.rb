require 'rails_helper'

RSpec.describe AvailabilitiesController, type: :controller do


  before(:each) do

    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability1= Availability.create!(start_time: "2016-04-05 15:42:04", end_time: "2016-04-05 18:42:04", studio: @studio1)
  end

  def add_availability_to_collection
    post :create, availability: {start_time: "2016-04-05 15:42:04", end_time: "2016-04-05 18:42:04"}, studio_id: @studio1.id
  end

  describe "create" do

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
end
