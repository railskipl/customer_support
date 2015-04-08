class FaqsController < ApplicationController
	before_action :default_action_tab

  def index
	@active_title = "Faqs"  	
  	@faqs = Faq.all
  end

	private
	def default_action_tab
	  	@action = "faqs"
	end

end
