class Admin::CustomersController < AdminController
	def index
	  @customers ||= User.all.customers
	end
end
