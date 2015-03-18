class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.order('created_at desc')
		@reviews = Review.where("agent_id = ?", current_user.id).order('id desc')
	end
end
