class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def store_params
    params.require(:store).permit(:name, :address, :openhour, :openmin, :closehour, :closemin, :latitude, :longitude, :user_id, :image)
  end

end
