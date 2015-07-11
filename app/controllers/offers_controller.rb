class OffersController < ApplicationController

	def create

		@store = Store.find(params[:store_id])
		@offer = @store.offers.build(offer_params)

		respond_to do |format|
      	if @offer.save
		        format.html { redirect_to @store, notice: 'Offer was successfully created.' }
		        format.js
     		else
		        format.html { render 'stores/show' }
		        format.js
		    end
  	end

	end

	def destroy	
		@store = Store.find(params[:store_id])
		@offer = @store.offers.find(params[:id]).destroy
		redirect_to @store

	end

	private

		def offer_params #nuestro modelo comment. Lo otro son los campos deo formulario
			params.require(:offer).permit(:name, :price)
		end	
end
