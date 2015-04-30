class Admin::NotificationsController < AdminController

  def index
  	if current_user.is_agent? || current_user.is_admin?
	  @notifications = current_user.agent_notifications.where("comment_status != ?","Published").includes(comment: :review).order("id desc")
	  @all_notifications = Notification.includes(comment: :review).order("id desc ")
	else
	  @notifications = current_user.jagent_notifications.includes(comment: :review).where("comment_status != ?","Published").order("id desc")
    end
  end 

end
