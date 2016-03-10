class StudiosController < ApplicationController
  def index
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
