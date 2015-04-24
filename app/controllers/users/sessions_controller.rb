class Users::SessionsController < Devise::SessionsController

  def new
  	@active_title = "Sign In"
	super		
  end
  
  def create
	  user = User.find_by_email(params[:user][:email])
	  if params["review_id"]
	  	if user.present? and user.valid_password?(params[:user][:password])
	  		self.resource = warden.authenticate!(auth_options)
			set_flash_message(:notice, :signed_in) if is_flashing_format?
			sign_in(resource_name, resource)
	  		redirect_to review_path(params["review_id"])
	  	else
	  		redirect_to new_user_session_url(:review_id => params[:review_id])
	  	end
	  else
		if user.present? and user.valid_password?(params[:user][:password])
			review = Review.find_by_guest_token(params[:guest_token])
			if review.present? && !review.user_id.present?
				review.user_id = user.id
				review.save
			end
		else
			flash[:alert] = "Invalid email or password."
			redirect_to new_user_session_url(:guest_token => params[:guest_token])
			return
		end
        unless params[:guest_token].present?
		  super
		else
			self.resource = warden.authenticate!(auth_options)
			set_flash_message(:notice, :signed_in) if is_flashing_format?
			sign_in(resource_name, resource)
			review = Review.find_by_guest_token(params[:guest_token])
	        if review.review_type == "complaint"
	          redirect_to new_review_path(:id => review.id, :review_type => "complaint")
	        else
	          redirect_to new_review_path(:id => review.id, :review_type => "compliment")
	        end
	    end
	end
  end

  def destroy
    logger.info "#{ current_user.email } signed out"
    super
  end
end
