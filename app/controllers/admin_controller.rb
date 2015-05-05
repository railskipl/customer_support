class AdminController < ActionController::Base
	before_filter :authenticate_user!
	before_filter :require_admin!
	layout 'admin'

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

	def require_admin!
		unless ['admin' ,'agent','jagent'].include? current_user.role
			redirect_to "/"
		end
	end

	def index
    @users ||= User.all
    @customers ||= User.all.customers
    if current_user.role == "jagent"
      @recent_reviews ||= Review.where('jagent_id = ? and user_id is not null',current_user.id).order("created_at desc")
      @reviews ||=  Review.junior_agent(current_user.id)
      @published_reviews ||= Review.published.where('jagent_id = ? and user_id is not null',current_user.id).order("created_at desc")
      @archived_reviews ||= Review.archived.where('jagent_id = ? and user_id is not null',current_user.id).order("created_at desc")
    else
      @reviews = Review.unpublished.where('(jagent_id = ? or agent_id = ?) and user_id is not null',current_user.id,current_user.id).order("created_at desc")
      @recent_reviews ||= Review.unpublished.where('user_id is not null').order("created_at desc")
      @published_reviews ||= Review.published.where('user_id is not null').order("created_at desc")
      @archived_reviews ||= Review.archived.where('user_id is not null').order("created_at desc")
    end
    @agents ||= User.all.agents

    @seos ||= Seo.all
    @archived_attachments ||= Review.where('archive_attachment = ? and user_id is not null',true)
    
    #if current_user.role == "admin"
      #For Supplier registration expire notification
      @supplier_registration = Supplier.select(:id,:supplier_name,:email,:industry,:mobile_number,:start_date, :end_date).where('start_date <= ? and end_date < ? and subscription = ? ', Date.today, Date.today,"Registered")
     
      unless @supplier_registration.blank?
        if @supplier_registration.count > 1
         flash[:notice] = "There are several supplier registrations has been expired."
       else
         flash.now[:notice] = "Supplier registration has been expired."
       end
      end
    #end
  end

  def searches
      @review_results = Review.admin_search params[:search]
      @comment_results = Comment.search params[:search]
      @company_results = Company.search params[:search]
      @town_results = Town.search params[:search]
      @location_results = Location.search params[:search]
      @supplier_results = Supplier.search params[:search]
      @user_results = User.search params[:search]
  end

  def set_current_user
    User.current = current_user
  end
  
  def change_password
    @user ||= current_user
  end
end
