class AgentMailer < ActionMailer::Base
  default from: "admin@xemaxema.com"

  def agent_mail(agent,password)
    @agent = agent
    @password = password
    mail(:to => @agent.email,
         :subject => "A message from Customer Support"
    )
  end
end
