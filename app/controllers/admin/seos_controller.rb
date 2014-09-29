class Admin::SeosController < ApplicationController
  layout "admin"
  before_action :default_tab
  before_action :get_seo , :only => [:edit,:update]
  def index
  	@seos = Seo.all
  end

  def update
  	@seo.update_attributes(seo_params)
  	flash[:notice] = "Seo was updated successfully."
  	redirect_to admin_seos_path 
  end

  private

  def get_seo
  	@seo = Seo.find(params[:id])
  end

  def seo_params
    params.require(:seo).permit(:meta_title, :meta_description,:meta_keyword)
  end

  def default_tab
  	@seo_tab = "seos"
  end
end
