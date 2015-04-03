class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.includes(review: :track_times).where("reviews.archive = ?",false).order('reviews.id desc')
		@reviews = Review.where("agent_id = ? and archive = ? and ispublished = ?", current_user.id,false,false).order('id desc')
	end
end
