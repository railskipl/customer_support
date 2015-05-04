class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.includes(review: :track_times).order('reviews.id desc')
		@reviews = Review.where("agent_id = ? || jagent_id = ? and archive = ? and ispublished = ?",current_user.id ,current_user.id,false,false).order('id desc')
	end
end
