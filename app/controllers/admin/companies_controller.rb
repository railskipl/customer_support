class Admin::CompaniesController < AdminController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :get_industries
	before_action :default_tab
  before_action :new_company, :only => [:create]

  load_and_authorize_resource

  def new_company
    @company = Company.new(company_params)
  end


  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.includes(:industry)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    respond_to do |format|
      if @company.save
        format.html { redirect_to [:admin, @company], notice: 'Company was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to  [:admin, @company], notice: 'Company was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:title, :user_id, :industry_id, :is_registered)
    end

    def get_industries
      @industries = Industry.all
    end

		def default_tab
    	@active_tab = 'companies'
    end
end
