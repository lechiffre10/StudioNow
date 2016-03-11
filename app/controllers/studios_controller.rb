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
  end

  def edit
    @studio = Studio.find_by_id(params[:id])
  end

  def update
  end

  def destroy
  end
end
