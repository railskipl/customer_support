class PagesController < ApplicationController

  def index
  		
		@page = Page.find_by_slug(params[:slug])
		if @page.present?
			@active_title = @page.slug
			@action = @page.name
			@sub_action = @page.slug
			@pages = Page.find_all_by_name(@page.name)
			render @page.template_name.present? ? @page.template_name : 'index'
		else
			redirect_to root_path
		end
  end

  def check_availiblity
		render :text => User.find_by_preferred_alias(params[:name]).present?
  end
end
