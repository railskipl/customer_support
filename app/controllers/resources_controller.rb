class ResourcesController < ApplicationController
  def show
  	@active_title = "resources"
  	@action = 'resources'
  	@resource_types = ResourceType.all
  	@resource_type = ResourceType.find_by_slug(params[:slug])
  	@resources = @resource_type.resources
  end
end