class Admin::ReportsController < ApplicationController
before_filter :get_default_for_reviews
layout "admin"
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
       
        @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null ',1.year.ago, Date.today,@industry)  if @industry.present?
        @reviews = Review.where('created_at >= ? and created_at <= ? and company_id = ? and user_id is not null ',1.year.ago, Date.today,@company)  if @company.present?
        @reviews = Review.where('created_at >= ? and created_at <= ? and town_id = ? and user_id is not null ',1.year.ago, Date.today,@town)  if @town.present?
        @reviews = Review.where('created_at >= ? and created_at <= ? and location_id = ? and user_id is not null ',1.year.ago, Date.today,@location)  if @location.present?
        @reviews = Review.where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null ',1.year.ago, Date.today,@review_type) if @review_type.present?
        @reviews = Review.where('created_at >= ? and created_at <= ? and nature_of_review = ? and user_id is not null ',1.year.ago, Date.today,@nature_of_review)  if @nature_of_review.present?
         #raise @reviews.inspect   
      else

      end
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end
	end

	def industry
		@industries = Industry.all
	end

	def company
		@companies = Company.all
        @suppliers = Supplier.all

        @supplier_registered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Registered')

        @supplier_unregistered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Not Registered')
		# Most compliments for supplier
		@most_compliment = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'compliment').map(&:company_id)
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	 
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'complaint').map(&:company_id)
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
	end

	def total_reviews
		#total reviews according to compliment and complaints
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'compliment').count
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and review_type = ?', 1.year.ago, Date.today,'complaint').count
	end

	def nature_of_complaints
		#nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Billing/accounts', 'compliment').count
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Booking', 'compliment').count
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Call centre efficiency', 'compliment').count
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Contract', 'compliment').count
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Delivery on time', 'compliment').count
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Feedback', 'compliment').count
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Going the extra mile', 'compliment').count
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Great attitude', 'compliment').count
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Pricing', 'compliment').count
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Refund', 'compliment').count
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Repairs', 'compliment').count
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Stock', 'compliment').count
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Other', 'compliment').count

		#nature of review for complaints
		@billing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Billing/accounts', 'complaint').count
		@booking_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Booking', 'complaint').count
		@call_center_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Call centre efficiency', 'complaint').count
		@contract_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Contract', 'complaint').count
		@delivery_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Delivery on time', 'complaint').count
		@feedback_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Feedback', 'complaint').count
		@going_extra_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Going the extra mile', 'complaint').count
		@great_attitude_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Great attitude', 'complaint').count
		@pricing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Pricing', 'complaint').count
		@refund_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Refund', 'complaint').count
		@repairs_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Repairs', 'complaint').count
		@stock_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Stock', 'complaint').count
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,'Other', 'complaint').count
	end

	def industry_level
		#raise params[:industry].inspect
		@industry = Industry.where('id = ?', params[:industry]).first
		
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'compliment').count
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@industry.id, 'complaint').count
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,  @industry.id ,'Billing/accounts', 'compliment').count
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id , 'Booking', 'compliment').count
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Call centre efficiency', 'compliment').count
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Contract', 'compliment').count
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Delivery on time', 'compliment').count
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Feedback', 'compliment').count
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Going the extra mile', 'compliment').count
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Great attitude', 'compliment').count
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Pricing', 'compliment').count
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Refund', 'compliment').count
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Repairs', 'compliment').count
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Stock', 'compliment').count
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Other', 'compliment').count

        #nature of review for complaints
		@billing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Billing/accounts', 'complaint').count
		@booking_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Booking', 'complaint').count
		@call_center_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Call centre efficiency', 'complaint').count
		@contract_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Contract', 'complaint').count
		@delivery_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Delivery on time', 'complaint').count
		@feedback_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Feedback', 'complaint').count
		@going_extra_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Going the extra mile', 'complaint').count
		@great_attitude_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Great attitude', 'complaint').count
		@pricing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Pricing', 'complaint').count
		@refund_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Refund', 'complaint').count
		@repairs_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Repairs', 'complaint').count
		@stock_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@industry.id,'Stock', 'complaint').count
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today, @industry.id,'Other', 'complaint').count
	end

   def supplier_level
   	    @company = Company.where('id = ?', params[:company]).first
   	    
		#total number of complaints/compliments according to each industry
		@compliments = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'compliment').count
		@complaints = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and review_type = ?',1.year.ago, Date.today,@company.id, 'complaint').count
        #total number of compliments and complaints according to the nature of review
        
        #nature of review for compliments
		@billing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today, @company.id ,'Billing/accounts', 'compliment').count
		@booking = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id , 'Booking', 'compliment').count
		@call_center = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre efficiency', 'compliment').count
		@contract = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Contract', 'compliment').count
		@delivery = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Delivery on time', 'compliment').count
		@feedback = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback', 'compliment').count
		@going_extra = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Going the extra mile', 'compliment').count
		@great_attitude = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Great attitude', 'compliment').count
		@pricing = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing', 'compliment').count
		@refund = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Refund', 'compliment').count
		@repairs = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs', 'compliment').count
		@stock = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Stock', 'compliment').count
		@others = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'compliment').count

        #nature of review for complaints
		@billing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Billing/accounts', 'complaint').count
		@booking_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Booking', 'complaint').count
		@call_center_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Call centre efficiency', 'complaint').count
		@contract_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Contract', 'complaint').count
		@delivery_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Delivery on time', 'complaint').count
		@feedback_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Feedback', 'complaint').count
		@going_extra_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Going the extra mile', 'complaint').count
		@great_attitude_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Great attitude', 'complaint').count
		@pricing_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Pricing', 'complaint').count
		@refund_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Refund', 'complaint').count
		@repairs_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Repairs', 'complaint').count
		@stock_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Stock', 'complaint').count
		@others_c = Review.where('created_at >= ? and created_at <= ? and user_id is not null and industry_id = ? and nature_of_review = ? and review_type = ?',1.year.ago, Date.today,@company.id,'Other', 'complaint').count
   end


   def supplier_profiles
   	  @supplier = Supplier.find(params[:supplier])
   end

   def user_profile
   	  @user_compliment = Review.where('created_at >= ? and created_at <= ? and review_type = ?  and user_id is not null ',1.year.ago, Date.today,'compliment').count 
      @user_complaint = Review.where('created_at >= ? and created_at <= ? and review_type = ?  and user_id is not null',1.year.ago, Date.today,'complaint').count
   	  @customers ||= User.all.customers
   	  @users = Review.select(:id,:user_id).where('created_at >= ? and created_at <= ? and user_id is not null', 6.months.ago, Date.today).map(&:user_id).uniq
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
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and user_id is not null ',start_from, start_to)
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and industry_id = ? and user_id is not null ',start_from, start_to,@industry)  if @industry.present?
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and company_id = ? and user_id is not null ',start_from, start_to,@company)  if @company.present?
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and town_id = ? and user_id is not null ',start_from, start_to,@town)  if @town.present?
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and location_id = ? and user_id is not null ',start_from, start_to,@location)  if @location.present?
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null ',start_from, start_to,@review_type) if @review_type.present?
           @reviews = Review.where('created_at >= ? and Date(created_at) <= ? and nature_of_review = ? and user_id is not null ',start_from, start_to,@nature_of_review)  if @nature_of_review.present?
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
   	 @industries = Industry.all
   	 send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
   end

   def company_xls
   	 @companies = Company.all
   	 send_data(render_to_string(:template=>"admin/reports/company_xls.html.erb" ) , :type=>"text/xls",:filename => "companies.xls")
   end

   def total_xls
   	 total_reviews
   	 nature_of_complaints
   	 send_data(render_to_string(:template=>"admin/reports/total_xls.html.erb" ) , :type=>"text/xls",:filename => "total_reviews.xls")
   end

   def most_company_xls
   	  # Most compliments for supplier
		@most_compliment = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'compliment').map(&:company_id)
   	    freq = @most_compliment.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_compliments = @most_compliment.max_by { |v| freq[v] }
   	    @max_compliment = freq.values.max
   	 
        # Most complaints for supplier
   	    @most_complaint = Review.select(:company_id).where('created_at >= ? and created_at <= ? and review_type = ? and user_id is not null',1.year.ago, Date.today, 'complaint').map(&:company_id)
   	    freq = @most_complaint.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   	    @value_complaints = @most_complaint.max_by { |v| freq[v] }
   	    @max_complaint = freq.values.max
   	    send_data(render_to_string(:template=>"admin/reports/most_company_xls.html.erb" ) , :type=>"text/xls",:filename => "suppliers_reviews.xls")
   end

   def registered_company_xls
   	  @supplier_registered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Registered')  
      send_data(render_to_string(:template=>"admin/reports/registered_company_xls.html.erb" ) , :type=>"text/xls",:filename => "Registered_suppliers.xls")
   end

   def unregistered_company_xls
   	  @supplier_unregistered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Not Registered')
      send_data(render_to_string(:template=>"admin/reports/unregistered_company_xls.html.erb" ) , :type=>"text/xls",:filename => "Unregistered_suppliers.xls")
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

  private

	def get_default_for_reviews
		@industries = Industry.all.order(:title)
		@companies = []
		@towns = []
		@locations = []
		@nature_of_reviews = NatureOfReview.all
		@nature_of_reviews = NatureOfReview.find_all_by_review_type(params[:review_type]) if params[:review_type].present?
	end

end
