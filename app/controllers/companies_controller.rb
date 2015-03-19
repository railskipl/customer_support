class CompaniesController < ApplicationController
	before_filter :get_default_for_filter
	before_action :default_action_tab, :only=>[:conversions, :registered, :unregistered, :polls_bloopers]

	def default_action_tab
  	@action = "my_account"
	end

        def user_review
  	  @active_tab = "review"
	  @reviews ||= Review.published.order("date")
          review = Review.new(review_params)
          @review_filter = review

	  if review.review_type
	    @reviews = @reviews.by_review_type review.review_type
	  end
    
	  if review.industry_id && review.industry_id !=0
	  	@reviews = @reviews.by_industry(review.industry_id)
	  end

	  if review.company_id && review.company_id !=0
	  	@reviews = @reviews.by_company(review.company_id)
	  end
	  
	  if review.town_id && review.town_id !=0
	  	@reviews = @reviews.by_town(review.town_id)
	  end
	  
	  if review.from_date && review.to_date
		@reviews = @reviews.within_range(review.from_date,review.to_date)
  	  end
  end

  def conversions
		@active_tab = "conversions"
    review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.all

    if review.industry_id  && review.industry_id !=0
    	@rcompanies = @rcompanies.by_industry(review.industry_id)
    end

    if review.company_id  && review.company_id !=0
    	@rcompanies = @rcompanies.by_company(review.company_id)
    end
    
#    if review.town_id && review.town_id !=0
#    	@rcompanies = @rcompanies.by_town(review.town_id)
#    end
    
    if review.from_date && review.to_date
			@rcompanies = @rcompanies.within_range(review.from_date,review.to_date)
		end
			
  end


  def registered
		@active_tab = "registered"
		review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.registered

    if review.industry_id  && review.industry_id !=0
    	@rcompanies = @rcompanies.by_industry(review.industry_id)
    end
    
    if review.company_id && review.company_id !=0
    	@rcompanies = @rcompanies.by_company(review.company_id)
    end
    
#    if review.town_id && review.town_id !=0
#    	@rcompanies = @rcompanies.by_town(review.town_id)
#    end
    
    if review.from_date && review.to_date
			@rcompanies = @rcompanies.within_range(review.from_date,review.to_date)
		end
  end

  def unregistered
		@active_tab = "unregistered"
    review = Review.new(review_params)
    @review_filter = review
    @rcompanies ||= Supplier.un_registered

    if review.industry_id && review.industry_id !=0
    	@rcompanies = @rcompanies.by_industry(review.industry_id)
    end
    
    if review.company_id && review.company_id !=0
    	@rcompanies = @rcompanies.by_company(review.company_id)
    end
    
#    if review.town_id && review.town_id !=0
#    	@rcompanies = @rcompanies.by_town(review.town_id)
#   	end
   	
    if review.from_date && review.to_date
			@rcompanies = @rcompanies.within_range(review.from_date,review.to_date)
		end
  end

  def polls_bloopers
		@active_tab = "polls-bloopers"
		@section = 'polls-bloopers'
		@sub_action = 'polls-bloopers'
		@polls = Poll.all
	end
	
	private

	def get_default_for_filter
		@industries = Industry.all.order(:title)
		@companies = []
		@towns = []
		@locations = []
	end

	def review_params
    if params[:review].present?
      params.require(:review).permit(:industry_id, :company_id, :review_type, :location_id, :town_id, :from_date, :to_date)
    end
  end
end
