class StudiosController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :edit]


  def index
    if params[:search] && params[:search] != ''

      @studios = Studio.search(params[:search])
      @studio_count = @studios.length

      @hash = Gmaps4rails.build_markers(@studios) do |studio, marker|
        marker.infowindow render_to_string(:partial => "/studios/infowindow", :locals => { :studio => studio})
        marker.lat studio.latitude
        marker.lng studio.longitude
      end

      matchers = Geocoder.search(params[:search])

      if !matchers.empty?
        @searched_coords = matchers[0].coordinates
      else
        @hash = []
        @searched_coords = ['soooooooooOOOOOooooooOOOOOOOoooooooooOOOOOOOOOOOo', 'mOOse']
        @studios = nil
      end

    else
      @studios = nil
      @hash = []
      @searched_coords = ['catie', 'stinks']
    end
  end

  def show
    @studio = Studio.find_by_id(params[:id])
    session[:studio_id] = params[:id]
    if @studio
      @latitude = @studio.latitude
      @longitude = @studio.longitude
      if @studio.images.any?
        @images = @studio.images
      end
    else
      flash[:errors] = ["No equipment found for that studio! It doesn't exist!"]
      redirect_to root_path
    end
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @studio = Studio.new
  end

  def create
    user = User.find_by_id(session[:user_id])
    @studio = user.studios.new(studio_params)
    @studio.update_attribute(:price, params[:studio][:price].gsub(/[^\d]/, '').to_i)
    if @studio.save
      redirect_to studio_path(@studio)
    else
      @errors = @studio.errors.full_messages
      render :new
    end
  end

  def edit
    @studio = Studio.find_by_id(params[:id])
    render :new
  end

  def update
    @studio = Studio.find_by_id(params[:id])
    @studio.update_attributes(studio_params)
    @studio.update_attribute(:price, params[:studio][:price].gsub(/[^\d]/, '').to_i)
    if @studio.save
      redirect_to studio_path(@studio)
    else
      @errors = @studio.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  def find_average
    @studio = Studio.find(params[:speed])
    render layout: false
  end


  private
  def studio_params
    params.require(:studio).permit(:name, :full_address, :description, :price, :latitude, :longitude, :website)
  end

end
