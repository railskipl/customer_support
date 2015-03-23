class Admin::PagesController < AdminController
	before_action :default_tab
  load_and_authorize_resource

	def index
		@pages = Page.all
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		@page.update_attributes(page_params)
		redirect_to admin_pages_path
	end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :subtitle ,:description, :slug, :image,:quote)
    end

		def default_tab
			@active_tab = 'pages'
		end
end
