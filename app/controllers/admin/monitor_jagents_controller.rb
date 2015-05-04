class Admin::MonitorJagentsController <  AdminController

	def index
		@myreviews = Review.where("(agent_id = ? || jagent_id = ? )and archive = ? and ispublished = ?",current_user.id ,current_user.id,false,false).order('id desc')
		@monitors = MonitorJagent.includes(review: :track_times).order('reviews.id desc')
	end
end
