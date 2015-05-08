class CommentsController < ApplicationController
#  before_filter :authenticate_user!
  before_filter :load_review

  def create
    @comment = @review.comments.new(comment_params)
    r = @comment.review
    if @comment.save
      Notification.create(:comment_id => @comment.id,:receiver_agent_id => r.agent_id, :receiver_jagent_id => r.jagent_id,:comment_status => "Pending" )
      if @review.monitor_jagent
        @review.monitor_jagent.comment_status = "Pending"
        @review.monitor_jagent.save
      end
      # ReviewMailer.delay.comment_mail(@review,@comment)
      redirect_to [@review], :notice => 'Your comment has been successfully submitted. However, it will only be published once it has been vetted by our team against our Terms and Conditions. You will receive an email confirming this.'
    else
      redirect_to [@review], :alert => 'Unable to add comment'
    end
  end

  private
  def load_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :user_id, :review_id, :supplier_id,:name,:email)
  end
end
