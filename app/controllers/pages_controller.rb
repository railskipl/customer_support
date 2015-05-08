class PagesController < ApplicationController

  def index
  		
		@page = Page.find_by_slug(params[:slug])
		if @page.present?
			@active_title1 = @page.slug == 'csr' ? "CSR" : @page.slug.titlecase
			@action = @page.name
			@sub_action = @page.slug
		    @bc = @page.title
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
