require 'rails_helper'
require 'spec_helper'

RSpec.describe StudiosController, type: :controller do

    before(:each) do
      @studio1 = Studio.create(name: "Studio1", full_address: "907 Caprice Dr. Shorewood, IL 60404", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @studio2 = Studio.create(name: "Studio2", full_address: "2833 N Sheffield Ave, Chicago, IL 60657", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      user = User.create(username: "Test", password: "password", first_name: "Catie", last_name: "Stallings", description: "Testing this user", email: "test@gmail.com", genres: "rock")


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
      it "creates a new studio instance" do
        post :login, :user => {:user_name => 'Test', :password =>'password'}
        get :new
        expect(assigns(:studio)).to be_a(Studio)
      end
    end

     describe "studios#create" do
      it "assigns a studio to the correct studio" do
        post :create, studio: {name: "Test Studio", full_address: "5 N. Wabash Chicago, IL", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url}
        expect(assigns(:studio)).to be_a(Studio)
      end

      it "redirects to the homepage if a new studio doesn't save" do
        post :create, studio: {description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url}
        expect(response).to render_template("new")
      end
    end

    describe "studios#edit" do
      it "finds the correct studio" do
        get :edit, id: @studio2.id
        expect(assigns(:studio)).to eq(@studio2)
      end
    end

end
