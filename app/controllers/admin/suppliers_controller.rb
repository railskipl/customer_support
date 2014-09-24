class Admin::SuppliersController < AdminController
  before_action :default_tab
  #load_and_authorize_resource

  def new_supplier
    @supplier = Supplier.new(supplier_params)
  end

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
    @towns = Town.all
    @locations = @towns.first.locations
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def create
    @supplier = Supplier.new(supplier_params)
      if @supplier.save
         redirect_to admin_supplier_path(@supplier), notice: 'supplier was successfully created.'
      else
         render action: 'new'
    end
  end

  def update
  @supplier = Supplier.find(params[:id])
      if @supplier.update(supplier_params)
         redirect_to admin_supplier_path(@supplier), notice: 'supplier was successfully updated.'
      else
         render action: 'edit'
      end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to admin_suppliers_url }
      format.json { head :no_content }
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:first_name, :last_name, :email, :address_line1, :address_line2, :town, :country, :title, :telephone_number, :mobile_number, :subscription, :start_date, :end_date, :supplier_name, :supplier_vat_Number, :industry, :city, :authorised_responder,:notes,:auth_resp2,:title2,:fname2,:lname2,:tno2,:mno2,:email2,:auth_resp3,:title3,:fname3,:lname3,:tno3,:mno3,:email3)
  end

  def default_tab
	  @active_tab = "suppliers"
  end
end
