class Admin::NotificationsController < AdminController

  def index
	@notifications = current_user.notifications
  end 

end
