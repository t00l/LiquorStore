class StoresController < InheritedResources::Base

  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /Stores
  # GET /Stores.json
  def index

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

      if t > opentime && t < closetime
        @url_icon = "http://maps.google.com/mapfiles/kml/pal3/icon55.png"
      else
        if opentime < closetime
          @url_icon = "http://www.sandwichvip.cl/imagenes/iconos/blueberry_32/close_delete.png"
        else
          if t > opentime
            @url_icon = "http://maps.google.com/mapfiles/kml/pal3/icon55.pngg"
          else
            @url_icon = "http://www.sandwichvip.cl/imagenes/iconos/blueberry_32/close_delete.png"
          end
        end
      end

      marker.lat store.latitude
      marker.lng store.longitude
      marker.infowindow "<a href='#{store_path(store)}'>
                          <div class='box' style='width:120px;'>
                            <h2>
                              <strong>
                              "+store.name+" 
                              </strong>
                            </h2>
                            <p>
                              "+"Atención:"+opentime+"-"+closetime+"
                            </p>
                            <img src="+store.image.to_s+">
                          </div>
                        </a>"
                    

      marker.picture({"url" => @url_icon,
                      "width" => 32 ,
                      "height" => 32});
    end
  end

  # GET /Stores/1http://www.emojibase.com/resources/img/emojis/gemoji/1f37a.png
  # GET /Stores/1.json
  def show
    @offer = @store.offers.build
    @offers = @store.offers.includes(:store).all.reverse 


    @store = Store.find(params[:id])
    result = request.location

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
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
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
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
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
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:address, :latitude, :longitude)
    end


  private

    def store_params
      params.require(:store).permit(:name, :address, :openhour, :openmin, :closehour, :closemin, :latitude, :longitude, :user_id, :image)
    end
end
