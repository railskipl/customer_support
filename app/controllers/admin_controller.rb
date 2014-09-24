class AdminController < ActionController::Base
	before_filter :authenticate_user!
	before_filter :require_admin!
	layout 'admin'

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

	def require_admin!
		unless ['admin' ,'agent'].include? current_user.role
			redirect_to "/"
		end
	end

	def index
		@users ||= User.all
		@customers ||= User.all.customers
		@reviews ||= Review.all.order("id desc")
		@agents ||= User.all.agents
		@recent_reviews ||= Review.unpublished.order("id desc")
		@published_reviews ||= Review.published.order("id desc")
		@archived_reviews ||= Review.archived.order("id desc")
	end

  def set_current_user
    User.current = current_user
  end
  
  def change_password
    @user ||= current_user
  end
end
