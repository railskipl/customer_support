class Notifier < ActionMailer::Base
  default from: "noreply@xemaxema.com"

  def contact(contact)
    @contact = contact
    mail(:to=>"info@xemaxema.com",:subject=>"#{@contact.email} contacted you.")
  end

   def contact_user(contact)
    @contact = contact
    mail(:to=> contact.email ,:subject=>"Thank You for contacting")
  end

end
