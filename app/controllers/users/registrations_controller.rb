class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token
  helper_method :resource, :resource_name, :devise_mapping

  def create

    @user = User.new(user_params)
     if params["other_type"].present?
        @user.lives_in = params["other_type"]    
     end
    if @user.save
      flash[:notice] = "You have signed up successfully. A confirmation email is sent to your e-mail.\n Please verify your email address."
      if params[:guest_token].present?
				review = Review.find_by_guest_token(params[:guest_token])
				if review.present?
					review.user_id = @user.id
					review.save
					flash[:notice] = "You have signed up successfully.A confirmation email is sent to your e-mail.\n Please verify your email address.\nYour review has been saved."
					redirect_to new_user_session_url(:guest_token => review.guest_token)
					return
				end
			end
      redirect_to new_user_session_url, :notice => "You have signed up successfully.A confirmation email is sent to your e-mail.\n Please verify your email address.\nYour review has been saved."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :salt, :other_type,:encrypted_password, :first_name, :last_name, :preferred_alias, :gender, :age, :dob, :country, :pobox, :postal_code, :town, :lives_in, :secret_question, :answer, :accpect_t_and_c,:address_line1,:address_line2,:avatar)
  end
end
