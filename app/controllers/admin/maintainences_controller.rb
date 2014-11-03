class Admin::MaintainencesController < AdminController

	def index
		@maintainence = Maintainence.first
	end

	def toggle_status
		@maintainence = Maintainence.find(params[:maintainence_id])
		if params[:s] == "true"
			@maintainence.status = true
		else
			@maintainence.status = false
		end
		@maintainence.save
		redirect_to :back
	end
end