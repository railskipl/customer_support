class ReviewsController < ApplicationController
	before_filter :authenticate_user!, :only=>[:edit ,:update, :delete]
	before_filter :get_default_for_reviews, :except =>[:index, :show]
	before_action :default_action_tab

	def index
  	@sub_action = 'my_reviews'
		@reviews = current_user ? current_user.reviews.published : []
	end
	
	def search_reviews
    @action = "review"
    @active_tab = "review"
    @reviews = []
    if params[:town_id]
      town = Town.find(params[:town_id])
      @reviews = town.reviews if town 
    elsif params[:supplier_id]
      supplier = Supplier.find(params[:supplier_id])
      comments = supplier.comments
      @reviews = []
      comments.each do |comment|
        @reviews << comment.review  
      end
      # @reviews = supplier.reviews if supplier 
    elsif params[:location_id] 
      location = Location.find params[:location_id]
      @reviews = location.reviews.where("ispublished = ?", true) if location 
    elsif params[:company_id]
      company = Company.includes(:reviews).find(params[:company_id])
      @reviews = company.reviews.where("ispublished = ?", true).order("date DESC") if company
    elsif params[:review_type]
    	@reviews = @reviews.where("review_type=? AND ispublished = ?",params[:review_type],true)
    end
	end

	def new
    if current_user.try(:role) == "admin" ||  current_user.try(:role) == 'agent' || current_user.try(:role) == 'jagent' 
      redirect_to admin_index_path
    else
      @page = Page.find_by_slug("how-to-write-good-review")
      if params[:id].present?
       @review = Review.find(params[:id])
       @companies = Industry.find(@review.industry_id).companies.order(:title)
       @towns = Company.find(@review.company_id).towns.order(:title).uniq!

       addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
       @locations = addresses.map {|a| a.location}
       @locations.sort_by { |k| k["value"] }
       @locations.uniq!
      else
  		 @review = Review.new
      end
    end
	end

	def show
    @review = Review.find(params[:id])
  end

  def chang_review_status
    if @review.change_date.nil?
      @review.change_date = DateTime.now
    else
      @review.change_date = nil
    end
  end

  def update
    @review = Review.find(params[:id])
    unless params[:review][:guest] == "guest_user"
      if params[:sad]
        @review.review_type = "complaint"
      elsif params[:happy]
        @review.review_type = "compliment"
      end
      if @review.update_attributes(review_params)
          flash[:notice] = "Your Review Successfully changed."
          redirect_to @review
      else
          render  :edit
      end
    else
      if verify_recaptcha
        if @review.update_attributes(review_params)
          if current_user
            ReviewMailer.delay.user_mail(@review)
            ReviewMailer.delay.admin_mail(@review)
            ReviewMailer.delay.agent_mail(@review)
            user = User.find(current_user.id) rescue nil
            user.update_column(:guest_token, nil) rescue nil
            flash[:notice] = "Your Review Successfully submitted."
            redirect_to reviews_url
          else
            render :new
          end
        else
          render  :new
        end
      else
        flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        redirect_to :back
      end
    end
  end 

	def create
    dt = Date.parse(params[:review][:date])
    hr = params["review"]["datetime(4i)"]
    min = params["review"]["datetime(5i)"]
    
    t = DateTime.new(dt.year, dt.month, dt.day, hr.to_i, min.to_i,0)
    kenyan_time = Time.now.utc + 3.hour
    industry = params[:txt_review_industry_id].to_s
    company  = params[:txt_review_company_id].to_s
    town     = params[:txt_review_town_id].to_s
    location = params[:txt_review_location_id].to_s

    @review ||= Review.new(review_params) 
    current_user.present? ? @review.user_id = current_user.id : @review.guest_token = generate_token

    if t > kenyan_time
      @companies = Industry.find(@review.industry_id).companies.order(:title)
      @towns = Company.find(@review.company_id).towns.order(:title).uniq!
      addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
      @locations = addresses.map {|a| a.location}
      @locations.sort_by { |k| k["value"] }
      @locations.uniq!
      flash[:notice] = "Please select past date"
      render :new
    else
      if (industry.present?)
        industry_db = Industry.find_or_create_by(:title => industry)
        @review.industry_id = industry_db.id
      end

      if (company.present?)
        company_db = Company.find_or_create_by(:title => company, :industry_id => @review.industry_id)
        @review.company_id = company_db.id
      end

      if (town.present?)
        town_db = Town.find_or_create_by(:title=>town)
        @review.town_id = town_db.id
      end

      if (location.present?)
        location_db = Location.find_or_create_by(:title=>location, :town_id=>@review.town_id)
        @review.location_id = location_db.id
      end

      Address.find_or_create_by(:town_id=>@review.town_id, :location_id=>@review.location_id, :company_id=>@review.company_id )
      if params["nature"].present?
          @review.nature_of_review = params["nature"]
      end
  	  if verify_recaptcha
        if @review.save
          if current_user
            ReviewMailer.delay.user_mail(@review)
            ReviewMailer.delay.admin_mail(@review)
            ReviewMailer.delay.agent_mail(@review)
            flash[:notice] = "Your Review Successfully submitted."
            redirect_to reviews_url
          else
            flash[:notice] = "You need to login to submit your reviews."
            redirect_to new_user_session_url(:guest_token => @review.guest_token)
          end
        else
          render :new
        end
      else
      @companies = Industry.find(@review.industry_id).companies.order(:title)
      @towns = Company.find(@review.company_id).towns.order(:title).uniq!
      addresses = Address.find_all_by_town_id_and_company_id(@review.town_id,@review.company_id)
      @locations = addresses.map {|a| a.location}
      @locations.sort_by { |k| k["value"] }
      @locations.uniq!
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render :new
      end
    end
  end

  def companies_by_industry
    if params[:id].present?
      @companies = Industry.find(params[:id]).companies.order(:title)
    else
      @companies = []
    end
    respond_to do |format|
      format.js
    end
  end

  def towns_by_company
    if params[:id].present?
      @towns = Company.find(params[:id]).towns.order(:title).uniq!
    else
      @towns = []
    end
    respond_to do |format|
      format.js
    end
  end 

  def locations_by_town_and_company
    if params[:id].present? and params[:company_id].present?
      addresses = Address.find_all_by_town_id_and_company_id(params[:id],params[:company_id])
      @locations = addresses.map {|a| a.location}
      @locations.sort_by { |k| k["value"] }
      @locations.uniq!
    else
      @locations = []
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end

	private

	def get_default_for_reviews
		@industries = Industry.all.order(:title)
		@companies = []
		@towns = []
		@locations = []
		@nature_of_reviews = NatureOfReview.all
		@nature_of_reviews = NatureOfReview.find_all_by_review_type(params[:review_type]) if params[:review_type].present?
	end

	def review_params
      params.require(:review).permit(:title, :industry_id, :company_id, :date, :town_id,:datetime, 
                                     :location_id, :personal_responsible, :nature_of_review,:message,
                                     :account_details,:ticket_number,:user_id, :token_number,:review_type,
                                     :file,:nature,:desired_outcome)
  end

	def default_action_tab
	  	@action = "my_account"
	end

	def generate_token
		SecureRandom.urlsafe_base64
	end
end
