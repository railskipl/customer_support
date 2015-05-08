class Admin::ResourcesController < AdminController
  before_action :default_tab
	before_action :new_resource, :only => [:create]

  load_and_authorize_resource

  def new_resource
    @resource = Resource.new(resource_params)
  end

	def index
		@resources = Resource.all
	end

	def new
		@resource = Resource.new
	end

  def create
      if @resource.save
        redirect_to admin_resources_path, notice: 'Resource was successfully created.'
      else
        render action: 'new'
      end
  end


	def edit
		@resource = Resource.find(params[:id])
	end

	def update
		@resource = Resource.find(params[:id])
		@resource.update_attributes(resource_params)
		redirect_to admin_resources_path
	end

  def destroy
    @resource.destroy
    redirect_to admin_resources_path
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:title,:description, :resource_type_id)
    end

		def default_tab
			@active_tab = 'resources'
		end
end
