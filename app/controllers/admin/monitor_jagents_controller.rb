class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.order('id desc')
		@reviews = Review.where("agent_id = ?", current_user.id).order('id desc')
	end
end
