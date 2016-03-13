require 'rails_helper'
require 'spec_helper'

RSpec.describe StudiosController, type: :controller do

    before(:each) do
      @studio1 = Studio.create(name: "Studio1", full_address: "907 Caprice Dr. Shorewood, IL 60404", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @studio2 = Studio.create(name: "Studio2", full_address: "2833 N Sheffield Ave, Chicago, IL 60657", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @studio3 = Studio.create(name: "Studio3", full_address: "900 N. Wood St. Chicago, IL 60622", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
      @studio4 = Studio.create(name: "Studio4", full_address: "16263 West Wyandot Lockport, IL 60441", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url)
    end

    describe "studio#index" do
      it "lists the studios near a given address" do
        get :index, {"search"=>"907 Caprice Dr. Shorewood IL, 60404"}
        expect(assigns(:studios)).to include(@studio1)
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
        get :new
        expect(assigns(:studio)).to be_a(Studio)
      end
    end

     describe "studios#create" do
      it "assigns a studio to the correct studio" do
        post :create, studio: {name: "Test Studio", full_address: "5 N. Wabash Chicago, IL", description: Faker::Hipster.sentence(rand(3..20)), price: 100, website: Faker::Internet.url}
        expect(assigns(:studio)).to be_a(Studio)
      end
    end

    describe "studios#edit" do
      it "finds the correct studio" do
        get :edit, id: @studio3.id
        expect(assigns(:studio)).to eq(@studio3)
      end
    end

end
