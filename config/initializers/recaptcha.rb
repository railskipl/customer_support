if Rails.env == "development"
	Recaptcha.configure do |config|
	  config.public_key  = '6LfYtvoSAAAAAM1aB8TGdjM1aZWGWbgDxE67uunw'
	  config.private_key = '6LfYtvoSAAAAACZrIAM-8-1cIkP_THyi22RMAcvl '
	  #config.proxy = 'http://0.0.0.0.3000'
	end
elsif Rails.env == "production"
	Recaptcha.configure do |config|
	  #xema
	  config.public_key  = '6LdeoAMTAAAAAD6RFowAvp9Ok89MfdOlhlLdlBPx'
	  config.private_key = '6LdeoAMTAAAAAF3MxT2JPO3lsG1NtkCPEDgRDkbZ'
	  #heroku
	  # config.public_key = '6LdxGfsSAAAAAGqbURclTwDO_JZnquS0VQQ3HX56'
      # config.private_key = '6LdxGfsSAAAAADYUG2YkJfW1oKK6YbjSm1DV_RuL'
	  #config.proxy = 'http://0.0.0.0.3000'
	end
else
	Recaptcha.configure do |config|
	  config.public_key  = '6LfYtvoSAAAAAM1aB8TGdjM1aZWGWbgDxE67uunw'
	  config.private_key = '6LfYtvoSAAAAACZrIAM-8-1cIkP_THyi22RMAcvl '
	  #config.proxy = 'http://0.0.0.0.3000'
	end
end