class StoreProductsController < ApplicationController

  def new
    bending.pry
    @store = Store.find(params[:store_id])
    @store_products = params
    redirect_to @store
  end

end
