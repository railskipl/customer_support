class Notifier < ActionMailer::Base
  default from: "support@xemaxema.com"

  def contact(contact)
    @contact = contact
    mail(:to=>"anlayst4@viciconsulting.co.ke",:subject=>"#{@contact.email} contacted you.")
  end

end
