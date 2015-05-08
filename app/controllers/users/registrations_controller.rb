class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only => :token
  helper_method :resource, :resource_name, :devise_mapping

  def new
    @active_title = "Sign Up"
    super   
  end

  def create
    @user = User.new(user_params)
    if params["other_type"].present?
      @user.lives_in = params["other_type"]    
    end
    if params[:guest_token].present?
      @user.guest_token = params[:guest_token]
    end
    if verify_recaptcha
      if @user.save
        #flash[:notice] = "You have signed up successfully. A confirmation email is sent to your e-mail.\n Please verify your email address."
        if params[:guest_token].present?
          review = Review.find_by_guest_token(params[:guest_token])
          if review.present?
            review.user_id = @user.id
            review.save
            redirect_to root_url(:guest_token => review.guest_token),:notice => 'You have signed up successfully. A confirmation email is sent to your e-mail. Please verify your email address. Your review has been saved.'
            return
          end
        end
        redirect_to root_url,:notice => 'Thank you for registering with xemaxema.com. You will shortly receive a confirmation email. Kindly verify your email address to submit your review. If you have not received this confirmation email please check your junk mail folder and add noreply@xemaxema.com to your contact list.'
      else
        render :action => :new
      end
    else
      if params[:guest_token].present?
        flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render :new
        # redirect_to new_user_session_url(:guest_token => params[:guest_token])
      else
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :salt, :other_type,:encrypted_password, :first_name, :last_name, :preferred_alias, :gender, :age, :dob, :country, :pobox, :postal_code, :town, :lives_in, :secret_question, :answer, :accpect_t_and_c,:address_line1,:address_line2,:avatar,:guest_token,:is_subscribe)
  end
end
