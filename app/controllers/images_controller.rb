class ImagesController < ApplicationController

  before_action :logged_in_user, only: [:new, :create, :destroy, :show]

  def new
    @studio = Studio.find(params[:studio_id])
    @image = Image.new
  end

  def create
    @studio = Studio.find_by_id(params[:studio_id])
    @image = @studio.images.new(images_params)
    if @image.save
      redirect_to studio_image_path(@studio, @image)
    end
  end

  def show
    @studio = Studio.find_by_id(params[:studio_id])
    @image = Image.find_by_id(params[:id])
  end


  private
  def images_params
      params.require(:image).permit(:media)
  end

end
