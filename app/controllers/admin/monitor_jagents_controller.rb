class Admin::MonitorJagentsController <  AdminController

	def index
		@monitors = MonitorJagent.all
	end
end
