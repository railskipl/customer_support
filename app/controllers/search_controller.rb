class SearchController < ApplicationController

  def index
  	 if params[:search].empty?
  	 	redirect_to :back, :alert => "Please fill in search field"
  	 else
  	  @active_title = "Search"
      @review_results = Review.search params[:search]
      @comment_results = Comment.search params[:search]
      @company_results = Company.search params[:search]
      @town_results = Town.search params[:search]
      @location_results = Location.search params[:search]
      @supplier_results = Supplier.search params[:search]
    end
  end
end
