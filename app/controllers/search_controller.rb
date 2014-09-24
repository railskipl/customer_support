class SearchController < ApplicationController

  def index
      @review_results = Review.search params[:search]
      @comment_results = Comment.search params[:search]
      @company_results = Company.search params[:search]
      @town_results = Town.search params[:search]
      @location_results = Location.search params[:search]
      @supplier_results = Supplier.search params[:search]
  end
end
