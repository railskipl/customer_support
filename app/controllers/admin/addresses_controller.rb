class Admin::AddressesController < AdminController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
	before_action :default_tab
  before_action :new_address, :only => [:create]

  load_and_authorize_resource

  def new_address
    @address = Address.new(address_params)
  end

  def index
    @addresses = Address.includes(:company,:town,:location)
  end

  def new
    @address = Address.new
  end

  def create
    if @address.save
      redirect_to admin_addresses_url, notice: 'Address was successfully created.'
    else
      render :new
    end

  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to admin_addresses_url, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    redirect_to admin_addresses_url
  end

  private
   # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def address_params
    params.require(:address).permit(:location_id,:town_id,:company_id)
  end

	def default_tab
		@active_tab = 'addresses'
	end
end
