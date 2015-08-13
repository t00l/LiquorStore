class OwnersController < ApplicationController

  def stores
    @stores = current_owner.stores if current_owner
  end

end
