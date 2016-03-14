require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability1= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
    @image = Image.create(media: File.open("app/assets/images/studio_photos/2.jpg"))
  end

  context '#new' do
    before { allow(controller).to receive(:current_user) {@user1}}

    it 'finds the right studio based on id' do
      get :new, studio_id: @studio1.id
      expect(assigns(:studio)).to eq @studio1
    end

    it 'creates a new image object' do
      get :new, studio_id: @studio1.id
      expect(assigns(:image)).to be_a Image
    end
  end

  context '#show' do
    before { allow(controller).to receive(:current_user) {@user1}}

    it 'finds the right studio' do
      get :show, studio_id: @studio1.id, id: @image.id
      expect(assigns(:studio)).to eq @studio1
    end

    it 'finds the right image' do
      get :show, studio_id: @studio1.id, id: @image.id
      expect(assigns(:image)).to eq @image
    end
  end


end
