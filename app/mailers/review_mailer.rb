class ReviewMailer < ActionMailer::Base
  default from: "noreply@xemaxema.com"

  def archive_mail(review,subject)
    begin
      @review = review
      @subject = subject
      mail(:to => @review.user.email, :subject => @subject)
    rescue
    end
  end

  def archive_adminmail(review, current_user)
    @review = review
    mail(:to => @review.user.email, :subject => "")
  end

  def publish_mail(review)
    @review = review
    mail(:to => @review.user.email, :subject => "Your review has been published")
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
    emails = @review.user.email + ",agent@xemaxema.com"
    mail(:to => emails, :subject => "Your review has received a new comment")
  end
  
  def other_comment_mail(review, comment)
    @review = review
    @comment = comment
    mail(:to => @comment.email, :subject => "Your comment has been published")
  end

  def company_comment_mail(review, comment)
    @review = review
    @comment = comment
    emails = @review.user.email + ",agent@xemaxema.com"
    mail(:to => emails, :subject => "The Company has responded to your review")
  end

  def comment_unpublish_mail(review, comment)
    @review = review
    @comment = comment
    mail(:to => @comment.email, :subject => "Your comment has been unpublished")
  end

  def review_unpublish_mail(review)
    @review = review
    emails = @review.user.email + ",agent@xemaxema.com"
    mail(:to => emails, :subject => "Your review has been unpublished")
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
    mail(:to =>  "agent@xemaxema.com", :subject => "New Review is Submitted")
  end

  # def admin_mail(review)
  #   @review = review
  #   admins = User.admins
  #   emails = admins.collect(&:email).join(",")
  #   if emails.present?    
  #     mail(:to => emails,:subject => "New Review is Submitted")
  #   end
  # end

  def abuse_report_mail(abuse_report)
    @abuse_report = abuse_report
    mail(:to => @abuse_report.user_email, :subject => @abuse_report.subject)
  end

  def ticket_closed_notification(review)
    @review = review
    emails = review.user.email + ",agent@xemaxema.com"
    mail(:to => emails, :subject => "Was your complaint resolved?")
  end

  def assignee_mail(review, comment)
    @review = review
    @comment = comment
    mail(:to => @review.agent.email, :subject => "Junior Agent Has Commented Onbehalf Of Supplier")
  end

  # def review_comment_mail(jagent, agent, ticket_number)
  #   @jagent = jagent
  #   @agent = agent
  #   @ticket_number = ticket_number
  #   mail(:to => @agent.email, :subject => "Junior Agent Has Modifide Comment")
  # end
end
