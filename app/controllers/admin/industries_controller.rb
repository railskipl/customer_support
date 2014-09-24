class Admin::IndustriesController < AdminController
  before_action :set_industry, only: [:show, :edit, :update, :destroy]
  before_action :default_tab
  before_action :new_industry, :only => [:create]

  load_and_authorize_resource

  def new_industry
    @industry = Industry.new(industry_params)
  end

  # GET /industries
  # GET /industries.json
  def index
    @industries = Industry.all
  end

  # GET /industries/1
  # GET /industries/1.json
  def show
  end

  # GET /industries/new
  def new
    @industry = Industry.new
  end

  # GET /industries/1/edit
  def edit
  end

  # POST /industries
  # POST /industries.json
  def create
    respond_to do |format|
      if @industry.save
        format.html { redirect_to [:admin,@industry], notice: 'Industry was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /industries/1
  # PATCH/PUT /industries/1.json
  def update
    respond_to do |format|
      if @industry.update(industry_params)
        format.html { redirect_to [:admin,@industry], notice: 'Industry was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /industries/1
  # DELETE /industries/1.json
  def destroy
    @industry.destroy
    respond_to do |format|
      format.html { redirect_to admin_industries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_industry
      @industry = Industry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def industry_params
      params.require(:industry).permit(:title, :user_id)
    end

    def default_tab
			@active_tab = "industries"
    end

end
