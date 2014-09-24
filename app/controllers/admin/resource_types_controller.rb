class Admin::ResourceTypesController < AdminController
  before_action :default_tab
  before_action :set_resource_type, only: [:edit, :update, :destroy]
	before_action :new_resource_type, :only => [:create]

  load_and_authorize_resource

  def new_resource_type
    @resource_type = ResourceType.new(resource_type_params)
  end

	def index
		@resource_types = ResourceType.all
	end

	def new
		@resource_type = ResourceType.new
	end

  def create
    if @resource_type.save
      redirect_to admin_resource_types_path, notice: 'ResourceType was successfully created.'
    else
      render action: 'new'
    end
  end

	def update
		@resource_type.update_attributes(resource_type_params)
		redirect_to admin_resource_types_path
	end

  def destroy
    @resource_type.destroy
    redirect_to admin_resource_types_path
  end


  private

		def set_resource_type
			@resource_type = ResourceType.find_by_slug(params[:id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_type_params
      params.require(:resource_type).permit(:name)
    end

		def default_tab
			@active_tab = 'resource_types'
		end

end
