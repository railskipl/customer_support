class PollsController < ApplicationController
	def show
	  @nav_tab = "reviews"
	  @active_tab = "polls & bloopers"
	  @poll = Poll.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @poll }
        format.json  { render :xml => @poll }
      end
	end
end
