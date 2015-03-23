Jmd::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  I18n.enforce_available_locales = false

  # Don't care if the mailer can't send.
#  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

#   config.after_initialize do
#   Bullet.enable = true
#   Bullet.alert = true
#   Bullet.bullet_logger = true
#   Bullet.console = true
#   #Bullet.growl = true
#   # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
#   #                 :password => 'bullets_password_for_jabber',
#   #                 :receiver => 'your_account@jabber.org',
#   #                 :show_online_status => true }
#   Bullet.rails_logger = true
#   #Bullet.bugsnag = true
  
#   Bullet.add_footer = true
#   # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
# end

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.delivery_method = :smtp

        config.action_mailer.smtp_settings = {
            :enable_starttls_auto => true,
            :address => "smtp.gmail.com",
            :port => 587,
            :domain => "imap.gmail.com",
            :authentication => :login,
            :user_name => "atishkunalinfotech@gmail.com",
            :password => "kunalinfotech"
        }
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

 #  config.action_mailer.delivery_method = :smtp
 #  config.action_mailer.default_url_options = { :host => 'http://69.25.137.192/' }
	# config.action_mailer.smtp_settings = {
	# 	:address              => "smtp.sendgrid.net",
	# 	:port                 => 25,
	# 	:domain               => 'rorfactory.com',
	# 	:user_name            => 'rorfact',
	# 	:password             => 'Shell@123',
	# 	:authentication      	=> 'plain',
	# 	:enable_starttls_auto => true
	# }
   config.action_mailer.raise_delivery_errors = true
end
