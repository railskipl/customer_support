class Admin::ReportsController < ApplicationController
layout "admin", :except => :industry_xls
before_filter :get_default_for_reviews
before_action :default_tab
layout :custom_layout
	def index
   	    total_reviews
   	    nature_of_complaints
   	    
   	  if params[:subaction] == "update"
   	    if params[:report][:other_type].present?
   	      @industry = params[:report][:other_type] rescue ""
   	    else
   	      @industry = params[:report][:industry_id] rescue ""
   	    end
      
   	    if params[:report][:txt_review_company_id].present?
   	    	@company = params[:report][:txt_review_company_id] rescue ""
   	    else
   	    	@company = params[:report][:company_id] rescue ""
   	    end
   	  	
   	  	if params[:report][:txt_report_town_id].present?
   	  		@town = params[:report][:txt_report_town_id] rescue ""
   	  	else
   	  		@town = params[:report][:town_id] rescue ""
   	  	end

   	  	if params[:report][:txt_review_location_id].present?
   	  		@location = params[:report][:txt_review_location_id] rescue ""
   	  	else
   	  		@location = params[:report][:location_id] rescue ""
   	  	end
   	  	
   	  	@review_type = params[:report][:review_type] rescue ""
   	  	@nature_of_review = params[:report][:nature_of_review_eq] rescue ""
       
        @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null ',1.year.ago, Date.today,@industry)  if @industry.present? rescue nil
        @reviews = Review.where('created_at >= ? and created_at <= ? and company_id = ? and user_id is not null ',1.year.ago, Date.today,@company)  if @company.present? rescue nil
        @reviews = Review.where('created_at >= ? and created_at <= ? and town_id = ? and user_id is not null ',1.year.ago, Date.today,@town)  if @town.present? rescue nil
        @reviews = Review.where('created_at >= ? and created_at <= ? and location_id = ? and user_id is not null ',1.year.ago, Date.today,@location)  if @location.present? rescue nil
        @reviews = Review.where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null ',1.year.ago, Date.today,@review_type) if @review_type.present? rescue nil
        @reviews = Review.where('created_at >= ? and created_at <= ? and nature_of_review = ? and user_id is not null ',1.year.ago, Date.today,@nature_of_review)  if @nature_of_review.present? rescue nil
         #raise @reviews.inspect   
      else

      end
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
	end

	def industry
		@industries = Industry.all rescue nil
		@compliment = Review.where('created_at >= ? and created_at <= ? and user_id is not null', 1.year.ago, Date.today) rescue nil
		
		@complaint_conversion = @compliment.where('review_type = ?', 'complaint') rescue nil
	    
	    @compliments = @compliment.where('change_date is not null') rescue nil 
	end 

	def company
		@companies = Company.all rescue nil
        @suppliers = Supplier.all rescue nil
        
        @compliment = Review.where('created_at >= ? and created_at <= ? and user_id is not null', 1.year.ago, Date.today) rescue nil
		 
		@complaint_conversion = @compliment.where('review_type = ?', 'complaint') rescue nil
	    
	    @compliments = @compliment.where('change_date is not null') rescue nil
        
        @supplier_registered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Registered') rescue nil

        @supplier_unregistered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Not Registered') rescue nil
		# Most compliments for supplier
		@most_compliment = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'compliment').map(&:company_id) rescue nil
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	 
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'complaint').map(&:company_id) rescue nil
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
	end

	def total_reviews
		#total reviews according to compliment and complaints
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'compliment').count rescue nil
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'complaint').count rescue nil
	end

	def nature_of_complaints
		#nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Billing/accounts', 'compliment') rescue nil
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Booking', 'compliment') rescue nil
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Call centre efficiency', 'compliment') rescue nil
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Contract', 'compliment') rescue nil
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Delivery on time', 'compliment') rescue nil
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Feedback', 'compliment') rescue nil
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Going the extra mile', 'compliment') rescue nil
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Great attitude', 'compliment') rescue nil
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Pricing', 'compliment') rescue nil
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Refund', 'compliment') rescue nil
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Repairs', 'compliment') rescue nil
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Stock', 'compliment') rescue nil
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Other', 'compliment') rescue nil

		#nature of review for complaints
		@bad_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Bad attitude', 'complaint') rescue nil
		@billing_account = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Billing/Accounts', 'complaint') rescue nil
		@booking_query = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Booking query', 'complaint') rescue nil
		@breach_of_contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Breach of contract', 'complaint') rescue nil
		@call_centre_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Call centre', 'complaint') rescue nil
		@damaged_goods = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Damaged goods', 'complaint') rescue nil
		@expiry = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Expiry date', 'complaint') rescue nil
		@feedback_response = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Feedback/response', 'complaint') rescue nil
		@hygiene = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Hygiene', 'complaint') rescue nil
		@Late_no_delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Late/no delivery', 'complaint') rescue nil
		@out_of_stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Out of stock', 'complaint') rescue nil
		@pricing_bar_codes = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Pricing/bar codes', 'complaint') rescue nil
		@repairs_servicing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Repairs/servicing', 'complaint') rescue nil
		@spam = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Spam', 'complaint') rescue nil
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Other', 'complaint') rescue nil
	end

	def industry_level #industries
		#raise params[:industry].inspect
		@industry = Industry.where('id = ?', params[:industry]).first
		
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'compliment').count
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'complaint').count
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,  @industry.id ,'Bad attitude', 'compliment').count rescue nil
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id , 'Booking', 'compliment').count rescue nil
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Call centre efficiency', 'compliment').count rescue nil
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Contract', 'compliment').count rescue nil
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Delivery on time', 'compliment').count rescue nil
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Feedback', 'compliment').count rescue nil
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Going the extra mile', 'compliment').count rescue nil
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Great attitude', 'compliment').count rescue nil
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Pricing', 'compliment').count rescue nil
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Refund', 'compliment').count  rescue nil
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Repairs', 'compliment').count rescue nil
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Stock', 'compliment').count rescue nil
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Other', 'compliment').count rescue nil

        #nature of review for complaints
		@bad_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Bad attitude', 'complaint').count rescue nil
		@billing_account = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Billing/Accounts', 'complaint').count rescue nil
		@booking_query = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Booking query', 'complaint').count rescue nil
		@breach_of_contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Breach of contract', 'complaint').count rescue nil
		@call_centre_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Call centre', 'complaint').count rescue nil
		@damaged_goods = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Damaged goods', 'complaint').count rescue nil
		@expiry = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Expiry date', 'complaint').count rescue nil
		@feedback_response = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Feedback/response', 'complaint').count rescue nil
		@hygiene = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Hygiene', 'complaint').count rescue nil
		@Late_no_delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Late/no delivery', 'complaint').count rescue nil
		@out_of_stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Out of stock', 'complaint').count rescue nil
		@pricing_bar_codes = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Pricing/bar codes', 'complaint').count rescue nil
		@repairs_servicing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Repairs/servicing', 'complaint').count rescue nil
		@spam = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Spam', 'complaint').count rescue nil
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Other', 'complaint').count rescue nil
	end

   def supplier_level #company/suppliers
   	    @company = Company.where('id = ?', params[:company]).first
   	    
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'compliment').count rescue nil
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'complaint').count rescue nil
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today, @company.id ,'Billing/accounts', 'compliment').count rescue nil
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id , 'Booking', 'compliment').count rescue nil
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre efficiency', 'compliment').count rescue nil
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Contract', 'compliment').count rescue nil
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Delivery on time', 'compliment').count rescue nil
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback', 'compliment').count rescue nil
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Going the extra mile', 'compliment').count rescue nil
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Great attitude', 'compliment').count rescue nil
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing', 'compliment').count rescue nil
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Refund', 'compliment').count rescue nil
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs', 'compliment').count rescue nil
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Stock', 'compliment').count rescue nil
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'compliment').count rescue nil

        #nature of review for complaints
		@bad_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Bad attitude', 'complaint').count rescue nil
		@billing_account = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Billing/Accounts', 'complaint').count rescue nil
		@booking_query = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Booking query', 'complaint').count rescue nil
		@breach_of_contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Breach of contract', 'complaint').count rescue nil
		@call_centre_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre', 'complaint').count rescue nil
		@damaged_goods = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Damaged goods', 'complaint').count rescue nil
		@expiry = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Expiry date', 'complaint').count rescue nil
		@feedback_response = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback/response', 'complaint').count rescue nil
		@hygiene = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Hygiene', 'complaint').count rescue nil
		@Late_no_delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Late/no delivery', 'complaint').count rescue nil
		@out_of_stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Out of stock', 'complaint').count rescue nil
		@pricing_bar_codes = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing/bar codes', 'complaint').count rescue nil
		@repairs_servicing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs/servicing', 'complaint').count rescue nil
		@spam = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Spam', 'complaint').count rescue nil
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'complaint').count rescue nil
   end


   def supplier_profiles
   	  @supplier = Supplier.find(params[:supplier])
   end

   def user_profile
   	  @user_compliment = Review.where('created_at >= ? and created_at <= ? and review_type = ?  and user_id is not null ',1.year.ago, Date.today,'compliment').count rescue nil
      @user_complaint = Review.where('created_at >= ? and created_at <= ? and review_type = ?  and user_id is not null',1.year.ago, Date.today,'complaint').count rescue nil
   	  @customers ||= User.where('created_at >= ? and created_at <= ?',1.year.ago, Date.today).customers rescue nil
   	  @users = Review.select(:id,:user_id).where('created_at >= ? and created_at <= ? and user_id is not null', 6.months.ago, Date.today).map(&:user_id).uniq rescue nil
   end

   def all_customers
   	  @customers ||= User.where('created_at >= ? and created_at <= ?',1.year.ago, Date.today).customers rescue nil
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
   end

   def active_customers
   	  @users = Review.select(:id,:user_id).where('created_at >= ? and created_at <= ? and user_id is not null', 6.months.ago, Date.today).map(&:user_id).uniq rescue nil
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
   end

   def customer_record
   	  @users = Review.select(:id,:user_id).where('created_at >= ? and created_at <= ? and user_id is not null', 1.year.ago, Date.today).map(&:user_id).uniq rescue nil
      send_data(render_to_string(:template=>"admin/reports/customer_record.html.erb" ) , :type=>"text/xls",:filename => "customer_summary.xls")
   end

   def archive_data
   	  if params[:subaction] == "update"
   	  	@industry = params[:report][:industry_name_eq] rescue ""
   	  	@company = params[:report][:company_name_eq] rescue ""
   	  	@town = params[:report][:town_name_eq] rescue ""
   	  	@location = params[:report][:location_name_eq] rescue ""
   	  	@review_type = params[:report][:review_type] rescue ""
   	  	@nature_of_review = params[:report][:nature_of_review_eq] rescue ""
   	  	start_from = params[:report][:start_date] rescue ""
   	  	start_to = params[:report][:end_date] rescue ""
   	  
        if start_from > start_to
        	flash[:notice] = "Start date cannot be greater than End date."
        else
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and user_id is not null ',start_from, start_to) rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null ',start_from, start_to,@industry)  if @industry.present? rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and company_id = ? and user_id is not null ',start_from, start_to,@company)  if @company.present?  rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and town_id = ? and user_id is not null ',start_from, start_to,@town)  if @town.present? rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and location_id = ? and user_id is not null ',start_from, start_to,@location)  if @location.present? rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null ',start_from, start_to,@review_type) if @review_type.present? rescue nil
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and nature_of_review = ? and user_id is not null ',start_from, start_to,@nature_of_review)  if @nature_of_review.present? rescue nil
        end
        #send_data(render_to_string(:template=>"admin/reports/archive_xls.html.erb" ) , :type=>"text/xls",:filename => "archive_data.xls")
      else

      end
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
   end

   def industry_xls
   	 @industries = Industry.all rescue nil
   	 send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
   end

   def company_xls
   	 @companies = Company.all rescue nil
   	 send_data(render_to_string(:template=>"admin/reports/company_xls.html.erb" ) , :type=>"text/xls",:filename => "companies.xls")
   end

   def total_xls
   	 total_reviews
   	 nature_of_complaints
   	 send_data(render_to_string(:template=>"admin/reports/total_xls.html.erb" ) , :type=>"text/xls",:filename => "total_reviews.xls")
   end

   def most_company_xls
   	  # Most compliments for supplier
		@most_compliment = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'compliment').map(&:company_id) rescue nil
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	    @compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@value_compliments, 'compliment') rescue nil
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'complaint').map(&:company_id) rescue nil
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
   	    @complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and company_id = ? and review_type = ?',1.year.ago, Date.today,@value_complaints, 'complaint') rescue nil
   	    send_data(render_to_string(:template=>"admin/reports/most_company_xls.html.erb" ) , :type=>"text/xls",:filename => "suppliers_reviews.xls")
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

  def registered_suppliers
  	@supplier_registered = Supplier.where('created_at >= ? and created_at <= ? and subscription = ?', 1.year.ago, Date.today,'Registered').order("created_at desc")  rescue nil
    respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def unregistered_suppliers
  	@supplier_unregistered = Supplier.where('created_at >= ? and created_at <= ? and subscription = ?', 1.year.ago, Date.today,'Not Registered').order("created_at desc") rescue nil
    respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def suppliers_profiles
  	@suppliers = Supplier.where('created_at >= ? and created_at <= ? ', 1.year.ago, Date.today).order("created_at desc") rescue nil
  	respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def conversion_industry
  	@industries = Industry.all rescue nil
  	respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def conversion_company
  	@companies = Company.all rescue nil
  	respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def jagent
  	@jagents = User.where('created_at >= ? and created_at <= ? and role = ?', 1.year.ago, Date.today, 'jagent')
    respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
  end

  def sagent
  	@sagents = User.where('created_at >= ? and created_at <= ? and role = ?', 1.year.ago, Date.today, 'agent')
    respond_to do |format|
        format.html # index.html.erb
        format.xls
    end
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

	def default_tab
	  	@active_tab = 'reports'
	end

	#method for allowing to user to use differnt layout to individual page.
      def custom_layout
        case action_name
         when "industry_xls"
            "no_layout"
         when "total_xls"
         	 "no_layout"
         when "company_xls"
         	"no_layout"
         when "customer_record"
         	"no_layout"
         when "most_company_xls"
         	"no_layout"
         else
          "admin"
        end
    end

end
