class StoresController < InheritedResources::Base

  private

    def store_params
      params.require(:store).permit(:name, :address, :schedule, :latitude, :longitude, :user_id)
    end
end

