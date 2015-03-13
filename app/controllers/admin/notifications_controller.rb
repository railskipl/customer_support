class Admin::NotificationsController < AdminController

  def index
  	if current_user.is_agent?
	  @notifications = current_user.agent_notifications.includes(comment: :review)
	else
	  @notifications = current_user.jagent_notifications.includes(comment: :review)
    end
  end 

end
