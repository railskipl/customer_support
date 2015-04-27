class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :new_poll, :get_defaults, :meta_defaults

	# Catch all CanCan errors and alert the user of the exception
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  private

	def get_defaults
   if params["controller"] =="devise/passwords" && params["action"] == "new"
     @active_title = "Forgotten your password"
   elsif params["controller"] =="devise/passwords" && params["action"] == "edit"
     @active_title = "Change your password"
   end
  	@resource_types = ResourceType.all
	end


  def meta_defaults
    seo = Seo.first
    if seo.present?
      @meta_title = seo.meta_title
      @meta_keyword = seo.meta_keyword
      @meta_description = seo.meta_description
    end
  end

  def permit!
    each_pair do |key, value|
      convert_hashes_to_parameters(key, value)
      self[key].permit! if self[key].respond_to? :permit!
    end
    @permitted = true
    self
  end

  def new_poll
    @top_advertise = Advertise.where('position=0 and start_date<=? and end_date>=?',Date.today,Date.today).sample
		@bottom_advertise = Advertise.where('position=1 and start_date<=? and end_date>=?',Date.today,Date.today).sample
      if params["controller"] == "pages" &&  params["slug"] != "csr"
        @performance = CompanyPerformance.where('start_date <= ? and end_date >= ? and box_type = ?', Date.today, Date.today, 'About Us').sample  
      elsif params["controller"] == "reviews" && params[:id]
        @performance = CompanyPerformance.where('start_date <= ? and end_date >= ? and box_type = ?', Date.today, Date.today, "show_review").sample  
      elsif params["controller"] == "reviews" && params[:company_id]
       @performance = CompanyPerformance.where('start_date <= ? and end_date >= ? and box_type = ?', Date.today, Date.today, "search_reviews").sample
      elsif params["controller"] =="pages" &&  params["slug"] == "csr"
        @performance = CompanyPerformance.where('start_date <= ? and end_date >= ? and box_type = ?', Date.today, Date.today, "csr").sample
      else
        @performance = CompanyPerformance.where('start_date <= ? and end_date >= ? and box_type = ?', Date.today, Date.today, params["controller"]).sample  
      end
   
    polls = Poll.all(:include=>'options',
    								  :conditions => ["start_date <= ? and end_date>=? and published=?", Date.today,Date.today,true])
    if polls.count > 0
      @poll = polls.sample
      @result = Result.new
    end
  end

  def after_sign_in_path_for(resource_or_scope)
  	if current_user.role == 'admin' ||  current_user.role == 'agent' || current_user.role == 'jagent'
  		admin_index_path
  	else
	    profile_path
	  end
  end

end
