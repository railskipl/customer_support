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

    respond_to do |format|
      if @contact_u.save
        Notifier.contact(@contact_u).deliver!
        format.html { redirect_to contact_us_url, notice: 'Your Contact info has been sent successfully.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_u_params
      params.require(:contact_u).permit(:first_name, :last_name, :email, :telephone, :message_type, :message)
    end

		def default_action_tab
	  	@action = "contact_us"
		end

end
