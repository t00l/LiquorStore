class StoresController < InheritedResources::Base

  before_action :set_store, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /Stores
  # GET /Stores.json
  def index
    @store = Store.new
    if params.key?(:query) && !params[:query].empty?
      @stores = Store.search_by_name(params[:query])
    else
      @stores = Store.all
    end

    #@stores = Store.all
    @hash = Gmaps4rails.build_markers(@stores) do |store, marker|

      time = Time.now
      t = time.strftime("%R").to_s

      opentime = store.openhour+":"+store.openmin
      closetime = store.closehour+":"+store.closemin
      schedule = opentime+"-"+closetime

      if opentime < closetime
        if t >= opentime && t <= closetime
          @url_icon = ActionController::Base.helpers.asset_path("openedstore.png")
        else
          @url_icon = ActionController::Base.helpers.asset_path("closedstore.png")
        end
      else  
        if t > closetime && t < opentime
          @url_icon = ActionController::Base.helpers.asset_path("closedstore.png")
        else
          @url_icon = ActionController::Base.helpers.asset_path("openedstore.png")
        end
      end

      store_name_norm = ActiveSupport::Inflector.transliterate(store.name)

      marker.lat store.latitude
      marker.lng store.longitude
 
      loc = store.latitude.to_s+", "+store.longitude.to_s

      location = Geocoder.search(loc)

      marker.json({:store_id => store.id,
                  :store_name => store.name,
                  :store_name_norm => store_name_norm,
                  :store_schedule => schedule, 
                  :store_image => store.image.to_s, 
                  :store_address => store.address, 
                  :store_rating => store.rate_average ? store.rate_average.avg : 0,
                  :store_location => location,
                  :store_lat => store.latitude,
                  :store_lng => store.longitude
                  })             

      marker.picture({"url" => @url_icon,
                      "width" => 36 ,
                      "height" => 36});
      
    end
  end

  # GET /Stores/1http://www.emojibase.com/resources/img/emojis/gemoji/1f37a.png
  # GET /Stores/1.json
  def show

    #form comments
    @comment = @store.comments.build    

    @comments = @store.comments.includes(:user).all.reverse

    #offers
    @offer = @store.offers.build
    @offers = @store.offers.includes(:store).all.reverse 

    #mapa
    result = request.location
    

    #gmap4rails
    @stores = Store.near([@store.latitude, @store.longitude], 5)
    @hash = Gmaps4rails.build_markers(@stores) do |stores, marker|
    marker.lat stores.latitude
    marker.lng stores.longitude
    end

  end

  # GET /Stores/new
  def new
    @store = Store.new
  end

  # GET /Stores/1/edit
  def edit
    
  end

  # POST /Stores
  # POST /Stores.json
  def create
    @store = current_owner.stores.build(store_params)
    @store.owner = current_owner

    # @store = Store.find(params[:id])
    @comment = @store.comments.build
    #tenemos que mostrar todos los comentarios del post y pasarlos a la vista
    @comments = @store.comments.includes(:user).all.reverse #muestra el arreglo de todos los comentarios


    respond_to do |format|
      if @store.save
        format.html { redirect_to @store}
        format.json { render :show, status: :created, store: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Stores/1
  # PATCH/PUT /Stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store }
        format.json { render :show, status: :ok, store: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Stores/1
  # DELETE /Stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  def create_store_product
    binding.pry
    params = params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def store_params
      params.require(:store).permit(:name, :address, :openhour, :openmin, :closehour, :closemin, :latitude, :longitude, :user_id, :image, products_attributes:[:id, :name,:image, :status])
    end

end
