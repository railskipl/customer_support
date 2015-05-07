class Admin::ReportsController < ApplicationController
before_filter :authenticate_user!
before_filter :correct_user
include Admin::ReportsHelper
layout "admin", :except => :industry_xls
before_filter :get_default_for_reviews
before_action :default_tab
layout :custom_layout
	
  def totalreviews
    total_reviews
  end

  def nature_of_complaints2
    nature_of_complaints
  end


  def nature_of_compliments
    nature_of_complaints
  end

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

        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and industry_id = ? and user_id is not null ',1.year.ago, Date.today,@industry)  if @industry.present? rescue nil
        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(created_at) <= ? and company_id = ? and user_id is not null ',1.year.ago, Date.today,@company)  if @company.present? rescue nil
        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(created_at) <= ? and town_id = ? and user_id is not null ',1.year.ago, Date.today,@town)  if @town.present? rescue nil
        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(created_at) <= ? and location_id = ? and user_id is not null ',1.year.ago, Date.today,@location)  if @location.present? rescue nil
        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ? and user_id is not null ',1.year.ago, Date.today,@review_type) if @review_type.present? rescue nil
        @reviews = Review.includes(:comments).where('Date(created_at) >= ? and Date(created_at) <= ? and nature_of_review = ? and user_id is not null ',1.year.ago, Date.today,@nature_of_review)  if @nature_of_review.present? rescue nil
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
		
	    if params[:subaction] == "industry_stat_record"
	   	  	@start_from = params[:report3][:start_date] rescue ""
	   	  	@start_to = params[:report3][:end_date] rescue ""
	   	  
	        if @start_from > @start_to
	          flash[:notice] = "Start date cannot be greater than End date."
	        else
	         
	        end
       else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
       end
	end 

	def company
		@companies = Supplier.all  rescue nil
        @suppliers = Supplier.all rescue nil
        if params[:subaction] == "company_stat_record"
	   	  	@start_from = params[:report6][:start_date] rescue ""
	   	  	@start_to = params[:report6][:end_date] rescue ""
	   	  
	        if @start_from > @start_to
	          flash[:notice] = "Start date cannot be greater than End date."
	        else
	         
	        end
       else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      	  #send_data(render_to_string(:template=>"admin/reports/industry_xls.html.erb" ) , :type=>"text/xls",:filename => "industries.xls")
       end
  
        @supplier_registered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Registered') rescue nil

        @supplier_unregistered = Supplier.select(:id, :supplier_name,:industry,:subscription,:start_date,:end_date).where('subscription = ?', 'Not Registered') rescue nil
		# Most compliments for supplier
		most_compliments
	end 

	

   def supplier_profiles
   	  @supplier = Supplier.find(params[:supplier])
      send_data(render_to_string(:template=>"admin/reports/supplier_profiles.html.erb" ) , :type=>"text/xls",:filename => "supplier_profile.xls")
   end

   def user_profile
      if params[:subaction] == "customer"
      
   	  	start_from = params[:report][:start_date] rescue ""
   	  	start_to = params[:report][:end_date] rescue ""
   	    
        if start_from > start_to
        	flash[:notice] = "Start date cannot be greater than End date."
        else
          @customers ||= User.where('Date(created_at) >= ? and Date(Date(created_at)) <= ?',start_from, start_to).customers rescue nil 
        end
      else
          @customers ||= User.where('Date(created_at) >= ? and Date(Date(created_at)) <= ?',1.year.ago, Date.today).customers rescue nil 
      end

      if params[:subaction] == "active_customer"
   	  	start_from = params[:report1][:start_date] rescue ""
   	  	start_to = params[:report1][:end_date] rescue ""
   	    
        if start_from > start_to
        	flash[:notice] = "Start date cannot be greater than End date."
        else
          @users = Review.select(:id,:user_id).where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null', start_from, start_to).map(&:user_id).uniq rescue nil
        end
      else
          @users = Review.select(:id,:user_id).where('Date(created_at) >= ? and Date(created_at) <= ? and user_id is not null', 6.months.ago, Date.today).map(&:user_id).uniq rescue nil
      end
    
   	  @user_compliment = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ?  and user_id is not null ',1.year.ago, Date.today,'compliment').count rescue nil
      @user_complaint = Review.where('Date(created_at) >= ? and Date(created_at) <= ? and review_type = ?  and user_id is not null',1.year.ago, Date.today,'complaint').count rescue nil
   	  
   	  #@customers ||= User.where('Date(created_at) >= ? and Date(created_at) <= ?',1.year.ago, Date.today).customers rescue nil
      respond_to do |format|
        format.html # index.html.erb
        format.xls
      end


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
           @reviews = Review.all
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null ',start_from, start_to) rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and industry_id = ? and user_id is not null ',start_from, start_to,@industry)  if @industry.present? rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and company_id = ? and user_id is not null ',start_from, start_to,@company)  if @company.present?  rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and town_id = ? and user_id is not null ',start_from, start_to,@town)  if @town.present? rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and location_id = ? and user_id is not null ',start_from, start_to,@location)  if @location.present? rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and review_type = ? and user_id is not null ',start_from, start_to,@review_type) if @review_type.present? rescue nil
           @reviews = @reviews.where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and nature_of_review = ? and user_id is not null ',start_from, start_to,@nature_of_review)  if @nature_of_review.present? rescue nil
        end
        #send_data(render_to_string(:template=>"admin/reports/archive_xls.html.erb" ) , :type=>"text/xls",:filename => "archive_data.xls")
      else

      end
      respond_to do |format|
        format.html # index.html.erb
        format.xls
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

  def registered_suppliers
    if params[:subaction] == "registered_suppliers"
   	  	@start_from = params[:report3][:start_date] rescue ""
   	  	@start_to = params[:report3][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @supplier_registered = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? and subscription = ?', @start_from, @start_to,'Registered').order("Date(created_at) desc")  rescue nil
          send_data(render_to_string(:template=>"admin/reports/registered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "registered_suppliers.xls")
        end
      elsif params[:id] == "data_dump"
      	@supplier_registered = Supplier.where('subscription = ?', 'Registered').order("Date(created_at) desc")  rescue nil
        send_data(render_to_string(:template=>"admin/reports/registered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "registered_suppliers.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
   	  	  @supplier_registered = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? and subscription = ?', @start_from, @start_to,'Registered').order("Date(created_at) desc")  rescue nil
   	  	  send_data(render_to_string(:template=>"admin/reports/registered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "registered_suppliers.xls")
      end
  end

  def unregistered_suppliers
    if params[:subaction] == "unregistered_suppliers"
   	  	@start_from = params[:report4][:start_date] rescue ""
   	  	@start_to = params[:report4][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @supplier_unregistered = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? and subscription = ?', @start_from, @start_to,'Not Registered').order("Date(created_at) desc") rescue nil
          send_data(render_to_string(:template=>"admin/reports/unregistered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "unregistered_suppliers.xls")
        end
    elsif params[:id] == "data_dump"
      	@supplier_unregistered = Supplier.where('subscription = ?', 'Not Registered').order("Date(created_at) desc")  rescue nil
        send_data(render_to_string(:template=>"admin/reports/unregistered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "unregistered_suppliers.xls")
    else
      	 @start_from = 1.year.ago 
   	  	 @start_to =  Date.today 
   	  	 @supplier_unregistered = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? and subscription = ?', @start_from, @start_to,'Not Registered').order("Date(created_at) desc") rescue nil
   	  	 send_data(render_to_string(:template=>"admin/reports/unregistered_suppliers.html.erb" ) , :type=>"text/xls",:filename => "unregistered_suppliers.xls")
    end
  end

  def suppliers_profiles
  	   if params[:subaction] == "supplier_profiles"
   	  	@start_from = params[:report2][:start_date] rescue ""
   	  	@start_to = params[:report2][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @suppliers = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? ', @start_from, @start_to).order("Date(created_at) desc") rescue nil
          send_data(render_to_string(:template=>"admin/reports/suppliers_profiles.html.erb" ) , :type=>"text/xls",:filename => "supplier_profiles.xls")
        end
      elsif params[:id] == "data_dump"
      	  @suppliers = Supplier.order("Date(created_at) desc") rescue nil
   	  	  send_data(render_to_string(:template=>"admin/reports/suppliers_profiles.html.erb" ) , :type=>"text/xls",:filename => "supplier_profiles.xls")
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
   	  	  @suppliers = Supplier.where('Date(created_at) >= ? and Date(created_at) <= ? ', @start_from,@start_to).order("Date(created_at) desc") rescue nil
   	  	  send_data(render_to_string(:template=>"admin/reports/suppliers_profiles.html.erb" ) , :type=>"text/xls",:filename => "supplier_profiles.xls")
      end
  end

  def polls
  	  if params[:subaction] == "poll_vote"
   	  	@start_from = params[:report][:start_date] rescue ""
   	  	@start_to = params[:report][:end_date] rescue ""
        if @start_from > @start_to
          flash[:notice] = "Start date cannot be greater than End date."
        else
          @start_from
          @start_to
        end
      else
      	  @start_from = 1.year.ago 
   	  	  @start_to =  Date.today 
      end
  	    @polls = Poll.where('Date(created_at) >= ? and Date(created_at) <= ? ', @start_from,@start_to)
  end

  def poll
  	@polls = Poll.all
  	send_data(render_to_string(:template=>"admin/reports/poll.html.erb" ) , :type=>"text/xls",:filename => "polls.xls")
  end

  def agent  
    @users = User.where("role != ?","user")
    @start_from = 1.year.ago 
    @start_to =  Date.today 
    @jagentid_reviews = Review.select(:id,:jagent_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null and jagent_id is not null ',@start_from, @start_to).pluck(:jagent_id).uniq rescue nil #Quantity 
    @track_times = TrackTime.select(:id,:user_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null ',@start_from, @start_to).pluck(:user_id).uniq rescue nil
  end

 def reviews_processed
    if params[:subaction] == "reviews_processed"
      user = User.find(params[:report][:agent]) rescue ""
      @start_from = Date.parse(params[:report][:start_date])
      @start_to = Date.parse(params[:report][:end_date] )
      if @start_from > @start_to
        flash[:notice] = "Start date cannot be greater than End date."
      else
        @start_from
        @start_to
      end
    elsif params[:id] == "data_dump"
       @track_times = TrackTime.select(:id,:user_id).pluck(:user_id).uniq rescue nil 
       send_data(render_to_string(:template=>"admin/reports/reviews_processed.html.erb" ) , :type=>"text/xls",:filename => "total_reviews_processed.xls")
    else
      @start_from = 1.year.ago 
      @start_to =  Date.today 
    end
    unless params[:id] == "data_dump" 
    if user && user.present?
      @track_times = TrackTime.select(:id,:user_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id = ? ',@start_from, @start_to,user.id).pluck(:user_id).uniq rescue nil
    else
      @track_times = TrackTime.select(:id,:user_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null ',@start_from, @start_to).pluck(:user_id).uniq rescue nil
    end
    send_data(render_to_string(:template=>"admin/reports/reviews_processed.html.erb" ) , :type=>"text/xls",:filename => "total_reviews_processed.xls")
    end
 end

 def agent_output
   if params[:subaction] == "agent_output"
      @start_from = params[:report1][:start_date] rescue ""
      @start_to = params[:report1][:end_date] rescue ""
      if @start_from > @start_to
        flash[:notice] = "Start date cannot be greater than End date."
      else
        @start_from
        @start_to
      end
    elsif params[:id] == "data_dump"
      @jagentid_reviews = Review.select(:id,:jagent_id).where('user_id is not null and jagent_id is not null ').pluck(:jagent_id).uniq rescue nil #Quantity 
      send_data(render_to_string(:template=>"admin/reports/agent_output.html.erb" ) , :type=>"text/xls",:filename => "agent_output.xls")
    else
      @start_from = 1.year.ago 
      @start_to =  Date.today 
    end
    unless params[:id] == "data_dump" 
    @jagentid_reviews = Review.select(:id,:jagent_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null and jagent_id is not null ',@start_from, @start_to).pluck(:jagent_id).uniq rescue nil #Quantity 
    send_data(render_to_string(:template=>"admin/reports/agent_output.html.erb" ) , :type=>"text/xls",:filename => "agent_output.xls")
    end
 end

 def agent_performance
   if params[:subaction] == "agent_performance"
      @start_from = params[:report2][:start_date] rescue ""
      @start_to = params[:report2][:end_date] rescue ""
      if @start_from > @start_to
        flash[:notice] = "Start date cannot be greater than End date."
      else
        @start_from
        @start_to
      end
    elsif params[:id] == "data_dump"
      @track_times = TrackTime.select(:id,:user_id).pluck(:user_id).uniq rescue nil
      send_data(render_to_string(:template=>"admin/reports/agent_performance.html.erb" ) , :type=>"text/xls",:filename => "agent_performance.xls")
    else
      @start_from = 1.year.ago 
      @start_to =  Date.today 
    end
    unless params[:id] == "data_dump"    
    @track_times = TrackTime.select(:id,:user_id).where('Date(created_at) >= ? and Date(Date(created_at)) <= ? and user_id is not null ',@start_from, @start_to).pluck(:user_id).uniq rescue nil
    send_data(render_to_string(:template=>"admin/reports/agent_performance.html.erb" ) , :type=>"text/xls",:filename => "agent_performance.xls")
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

  def correct_user
    user = current_user.is? :admin
    unless user
        flash[:notice] = "Access denied, there is no such page available."
        redirect_to admin_index_path
    end
  end

	#method for allowing to user to use differnt layout to individual page.
      def custom_layout
        case action_name
         when "industry_xls"
            "no_layout"
         when "supplier_profiles"
            "no_layout"
         when "total_xls"
         	 "no_layout"
         when "industry_level"
          "no_layout"
        when "supplier_level"
          "no_layout"
         when "company_xls"
         	"no_layout"
         when "customer_record"
         	"no_layout"
         when "most_company_xls"
         	"no_layout"
         when "conversion_industry"
         	"no_layout"
         when "conversion_company"
         	"no_layout"
         when "company_xls"
         	"no_layout"	
         when "suppliers_profiles"
         	"no_layout"
         when "registered_suppliers"
         	"no_layout"
         when "unregistered_suppliers"
         	"no_layout"
         when "all_customers"
         	"no_layout"
         when "jagent"
         	"no_layout"
         when "sagent"
         	"no_layout"
         when "poll"
            "no_layout"	
         when "industry_conversion"
           "no_layout"	
         when "company_conversion"		
           "no_layout"
         when "reviews_processed"
           "no_layout"
         when "agent_output"
           "no_layout"
         when "agent_performance"
           "no_layout"
                                                                                                                                                                                                            																				
         else
          "admin"
        end
    end

end
