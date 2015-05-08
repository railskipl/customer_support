class ContactUsController < ApplicationController

  before_action :default_action_tab
  def new
    @contact_u = ContactU.new
  end

  def create
    @contact_u = ContactU.new(contact_u_params)
    if params["other_type"].present?
      @contact_u.message_type = params["other_type"]
    end

      if verify_recaptcha
        if @contact_u.save
          Notifier.delay.contact(@contact_u)
          Notifier.delay.contact_user(@contact_u)
          redirect_to contact_us_url, notice: 'Your query has been submitted successfully and we will be in touch shortly. Thank you.'
        else
          render action: 'new' 
        end
      else
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render action: 'new' 
      end
  end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_u_params
      params.require(:contact_u).permit(:first_name, :last_name, :email, :telephone, :message_type, :message)
    end

		def default_action_tab
      @active_title = "contact_us"
	  	@action = "contact_us"
		end

end
