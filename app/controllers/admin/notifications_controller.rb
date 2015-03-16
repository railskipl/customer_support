class Admin::NotificationsController < AdminController

  def index
  	if current_user.is_agent?
	  @notifications = current_user.agent_notifications.includes(comment: :review).order("id desc")
	  @all_notifications = Notification.includes(comment: :review).order("id desc ")
	else
	  @notifications = current_user.jagent_notifications.includes(comment: :review).order("id desc")
    end
  end 

end
