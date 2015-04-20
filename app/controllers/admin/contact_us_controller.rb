class Admin::ContactUsController < AdminController
	def index
		@active_tab = 'contactus'
		@contacts = ContactU.all
	end
end
