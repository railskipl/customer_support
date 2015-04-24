class WelcomeController < ApplicationController
  layout 'application'

  def index
  	@active_tab = "Home"
    @action = 'view_report'
	  @sub_action = 'review'
    @reviews = Review.where('user_id IS NOT NULL AND ispublished IS NOT FALSE',:limit=>5).order(created_at: :desc)
  end

end
