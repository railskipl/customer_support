class Admin::CompanyPerformancesController < ApplicationController
  layout "admin"
  before_action :default_tab
	before_action :get_params, :only =>[:edit,:update,:destroy]
  #load_and_authorize_resource
    def index
      @company_performances = CompanyPerformance.all
    end

    def new
      @company_performance = CompanyPerformance.new
    end

    def create
      @company_performance = CompanyPerformance.new(company_params)
      if @company_performance.save
      	 flash[:notice] = "Successfully created."
      	 redirect_to admin_company_performances_path
      else
         render :new
      end
    end

    def update
      respond_to do |format|
        if @company_performance.update(company_params)
          format.html { redirect_to admin_company_performances_path, notice: 'Company performances was successfully updated.' }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    def destroy
      @company_performance.destroy
      flash[:notice] = "Successfully destroyed."
      redirect_to admin_company_performances_path
    end

	private

	 def company_params
	 	params.require(:company_performance).permit(:best_performance, :worst_performance, :start_date, :end_date, :performance_img,:box_type)
	 end

	 def get_params
	 	@company_performance = CompanyPerformance.find(params[:id])
	 end

   def default_tab
     @active_tab = 'company_performances'
   end
end
