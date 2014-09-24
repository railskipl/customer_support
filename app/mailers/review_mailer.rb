class ReviewMailer < ActionMailer::Base
  default from: "admin@xemaxema.com"

  def archive_mail(review)
    begin
      @review = review
      mail(:to => @review.user.email, :subject => "A message from Customer Support")
    rescue
    end
  end

  def archive_adminmail(review, current_user)
    begin
      @review = review
      @agent = current_user
      admins = User.admins
      emails = admins.collect(&:email).join(",")
      if emails.present?    
        mail(:to => emails, :subject => "Review is pushed into Archive")
      end
    rescue
    end
  end

  def publish_mail(review)
    @review = review
    mail(:to => @review.user.email, :subject => "A message from Customer Support")
  end

  def publish_adminmail(review, current_user)
    @review = review
    @agent = current_user
    admins = User.admins
    emails = admins.collect(&:email).join(",")
    if emails.present?    
      mail(:to => emails, :subject => "Review is published")
    end
  end

  def user_mail(review)
    @review = review
    mail(:to => @review.user.email, :subject => "Your review has been submitted")
  end

  def comment_mail(review, comment)
    @review = review
    @comment = comment
    mail(:to => @review.user.email, :subject => "Customer Support comment on your review")
  end

  def comment_agent_mail(review,comment,current_user)
    @review = review
    @comment = comment
    @user = current_user
    agents = User.agents
    emails = agents.collect(&:email).join(",")
    if emails.present?    
      mail(:to => emails, :subject => "New Comment is Submitted")
    end
  end

  def agent_mail(review)
    @review = review
    agents = User.agents
    emails = agents.collect(&:email).join(",")
    if emails.present?
      mail(:to => emails, :subject => "New Review is Submitted")
    end
  end

  def admin_mail(review)
    @review = review
    admins = User.admins
    emails = admins.collect(&:email).join(",")
    if emails.present?    
      mail(:to => emails,:subject => "New Review is Submitted")
    end
  end
end
