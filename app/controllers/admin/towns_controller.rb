class Admin::TownsController < AdminController
	before_action :set_town, only: [:show, :edit, :update, :destroy]
	before_action :default_tab
  before_action :new_town, :only => [:create]
  load_and_authorize_resource

  def new_town
    @town = Town.new(town_params)
  end

  # GET /towns
  # GET /towns.json
  def index
    @towns = Town.all
  end

  # GET /towns/1
  # GET /towns/1.json
  def show
  end

  # GET /towns/new
  def new
    @town = Town.new
  end

  # GET /towns/1/edit
  def edit
  end

  # POST /towns
  # POST /towns.json
  def create
    respond_to do |format|
      if @town.save
        format.html { redirect_to [:admin,@town], notice: 'Town was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /towns/1
  # PATCH/PUT /towns/1.json
  def update
		if @town.update(town_params)
		  redirect_to admin_towns_url, notice: 'Town was successfully updated.'
		else
		  render action: 'edit'
		end
  end

  # DELETE /towns/1
  # DELETE /towns/1.json
  def destroy
    @town.destroy
  	redirect_to admin_towns_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_town
      @town = Town.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def town_params
    	puts params
      params.require(:town).permit(:title, :user_id)
    end

    def default_tab
    	@active_tab = 'towns'
    end
end
