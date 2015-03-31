class Admin::CustomersController < AdminController
	def index
	  @active_tab = "customers"
	  @customers ||= User.all.customers
	end
end
