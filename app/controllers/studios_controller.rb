class StudiosController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :edit]


  def index
    if params[:search] && params[:search] != ''

      @studios = Studio.search(params[:search])

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
    @latitude = @studio.latitude
    @longitude = @studio.longitude
    if @studio.images.any?
      @images = @studio.images
    end
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @studio = Studio.new
  end

  def create
      user = User.find_by_id(session[:user_id])
      @studio = user.studios.new(studio_params)
      if @studio.save
        redirect_to studio_path(@studio)
      else
        @errors = @studio.errors.full_messages
        render :new
      end
  end

  def edit
    @studio = Studio.find_by_id(params[:id])
  end

  def update
  end

  def destroy
  end


  private
  def studio_params
    params.require(:studio).permit(:name, :full_address, :description, :price, :latitude, :longitude, :website)
  end

end
