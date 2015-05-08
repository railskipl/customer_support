class ResultsController < ApplicationController


  def index
  	@poll = Poll.all
	end

  def create
  	if params[:result]
	    poll = Poll.find(params[:result][:poll_id])
  	  poll_title = Base64.encode64(poll.title)
		end
		
    if cookies["#{poll_title}"].present?
      redirect_to root_path, notice: 'You have already voted.'
      return
    end
		
		if params[:result]
		  @result = Result.new(result_params)

		  if current_user.present?
		     @result.user_id = current_user.id
		  end

		  if @result.save
		      cookies["#{poll_title}"] = true
		      redirect_to poll_path(@result.poll_id), notice: 'Your vote has been successfully submitted.'
		      return
		  else
		      redirect_to root_path, notice: 'Please select any option for survery.'
		      return
		  end
		end
    redirect_to root_path, notice: 'Please select any option for survery.'
    return
  end

  def result_params
    params.require(:result).permit(:id, :poll_id, :option_id, :user_id)
  end

end
