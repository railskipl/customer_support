class Notifier < ActionMailer::Base
  default from: "noreply@xemaxema.com"

  def contact(contact)
    @contact = contact
    mail(:to=>"info@xemaxema.com",:subject=>"A new query has been received")
  end

   def contact_user(contact)
    @contact = contact
    mail(:to=> contact.email ,:subject=>"Your query was successfully submitted")
  end

end
