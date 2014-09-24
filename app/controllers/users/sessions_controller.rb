class Users::SessionsController < Devise::SessionsController

  def create
	  user = User.find_by_email(params[:user][:email])
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
		super
  end

  def destroy
    logger.info "#{ current_user.email } signed out"
    super
  end
end
