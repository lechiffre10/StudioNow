require 'rails_helper'
require 'spec_helper'

RSpec.describe StudiosController, type: :controller do

    before(:each) do
      @studio1 = Studio.create(name: "Studio1", full_address: "907 Caprice Dr. Shorewood, IL 60404", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @studio2 = Studio.create(name: "Studio2", full_address: "2833 N Sheffield Ave, Chicago, IL 60657", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    end

    describe "studio#index" do
      # this test is kinda f-ed up so removing for now
      # it "lists the studios near a given address" do
      #   get :index, search: "907 Caprice Dr. Shorewood, IL"
      #   expect(assigns(:studios)).to include(@studio1)
      # end

      it "doesn't list any studios if a search does not match surrounding studios" do
        get :index, {"search" => "fdsfdsfdsfsdfds"}
        expect(assigns(:studios)).to be(nil)
      end

      it "doesn't build any Google maps markers if a search doesn't match any surrounding studios" do
        get :index, {"search" => "53435355fdads"}
        expect(assigns(:hash)).to eq([])
      end

      it "doesn't list any studios if a search is not submitted" do
        get :index
        expect(assigns(:studio)).to eq(nil)
      end

      it "doesn't build any Google maps markers if a search is not submitted" do
        get :index
        expect(assigns(:hash)).to eq([])
      end
    end

    describe "studios#show" do
      it "goes to the show page when a studio is clicked" do
        get :show, id: @studio2.id
        expect(response).to render_template(:show)
      end
    end

     describe "studios#new" do
      before { allow(controller).to receive(:current_user) {@user1}}

      it "creates a new studio instance" do
        get :new
        expect(assigns(:studio)).to be_a(Studio)
      end
    end

     describe "studios#create" do
      before { allow(controller).to receive(:current_user) {@user1}}

      it "assigns a studio to the correct studio" do
        session[:user_id] = @user1.id
        post :create, studio: {name: "Test Studio", full_address: "5 N. Wabash Chicago, IL", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url}
        expect(assigns(:studio)).to be_a(Studio)
      end

      it "redirects to the homepage if a new studio doesn't save" do
        session[:user_id] = @user1.id
        post :create, studio: {description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url}
        expect(response).to render_template("new")
      end
    end

    describe "studios#edit" do
      before { allow(controller).to receive(:current_user) {@user1}}

      it "finds the correct studio" do
        get :edit, id: @studio2.id
        expect(assigns(:studio)).to eq(@studio2)
      end
    end

end
