class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.all
		@reviews = Review.where("agent_id = ?", current_user.id)
	end
end
