class WelcomeController < ApplicationController
  layout 'application'

  def index
  	if current_user.try(:role) == "admin" ||  current_user.try(:role) == 'agent' || current_user.try(:role) == 'jagent' 
  	  redirect_to admin_index_path
  	else
	  @action = 'view_report'
	  @sub_action = 'review'
      @reviews = Review.where('user_id IS NOT NULL AND ispublished IS NOT FALSE',:limit=>5).order(date: :desc)
  	end
  end

end
