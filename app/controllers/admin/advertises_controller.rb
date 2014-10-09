class Admin::AdvertisesController < AdminController
  before_action :default_tab
  before_action :get_advertise ,:only => [:edit, :destroy,:update]
#  load_and_authorize_resource :class=>'Advertise'

  def index
    @advertises = Advertise.all
  end

  def new
    @advertise = Advertise.new
  end

  def create
	    @advertise = Advertise.new(advertise_params)
      if @advertise.save
         redirect_to admin_advertises_path, notice: 'advertise was successfully created.'
      else
         render action: 'new'
    end
  end

  def update
      if @advertise.update(advertise_params)
         redirect_to admin_advertises_path, notice: 'advertise was successfully updated.'
      else
         render action: 'edit'
      end
  end

  def destroy
    @advertise.destroy
    respond_to do |format|
      format.html { redirect_to admin_advertises_url }
      format.json { head :no_content }
    end
  end

  private

  def advertise_params
    params.require(:advertise).permit(:image, :start_date, :end_date, :position,:link,:text_msg)
  end

  def get_advertise
    @advertise = Advertise.find(params[:id])
  end

  def default_tab
	  @active_tab = "advertises"
  end
end
