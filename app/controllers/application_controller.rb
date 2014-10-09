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
		@performance = CompanyPerformance.where('start_date <= ? and end_date >= ?', Date.today, Date.today).sample
    polls = Poll.all(:include=>'options',
    								  :conditions => ["start_date <= ? and end_date>=? and published=?", Date.today,Date.today,true])
    if polls.count > 0
      @poll = polls.sample
      @result = Result.new
    end
  end

  def after_sign_in_path_for(resource_or_scope)
  	if current_user.role == 'admin' ||  current_user.role == 'agent'
  		admin_index_path
  	else
	    reviews_path
	  end
  end

end
