class UsersController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	before_action :default_action_tab, :only => [:show, :edit]
    before_action :get_user , :only => [:show, :edit, :update]
    
	def default_action_tab
  	@action = "my_account"
	end

  def show
    @active_tab = 'my_account'
  	@sub_action = 'show_profile'
  end

  def edit
     @active_tab = 'my_account'
  	@sub_action = 'update_profile'
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    #if verify_recaptcha
      if @user.update(user_params)
        flash[:notice] = "Your account has been sucessfully updated."
        sign_in @user , :bypass => true
        redirect_to profile_url
      else
        flash[:alert] = @user.errors.full_messages.map { |msg| msg.html_safe }.join("<br/>")
        redirect_to edit_profile_path
      end
    # else
    #   flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
    #   flash.delete :recaptcha_error
    #   redirect_to edit_profile_path
    # end
 end
  
  private

  def get_user
     @user = User.find(current_user.id)
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :salt, :encrypted_password, :first_name, :last_name, :preferred_alias, :gender, :age, :dob, :country, :pobox, :postal_code, :town, :lives_in, :secret_question, :answer, :accept_t_and_c,:address_line1,:address_line2,:avatar,:accept_t_and_c)
  end
end