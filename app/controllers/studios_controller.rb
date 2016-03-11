class StudiosController < ApplicationController
  def index
    @google_api_key = ENV['GOOGLE_MAPS_API_KEY']
    puts params[:search]
    if params[:search]
      @studios = Studio.search(params[:search])
    else
      @studios = nil
    end
  end

  def show
    @studio = Studio.find_by_id(params[:id])
  end

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      redirect_to studio_path(@studio)
    else
      flash[:notice] = "Unable to create studio"
      redirect_to 'welcome#index'
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
    params.require(:studio).permit(:name, :address, :city, :state, :zip_code, :description, :price, :lat, :lng, :website)
  end

end
