class CommentsController < ApplicationController
#  before_filter :authenticate_user!
  before_filter :load_review

  def create
    @comment = @review.comments.new(comment_params)
    r = @comment.review
    if @comment.save
      Notification.create(:comment_id => @comment.id,:receiver_agent_id => r.agent_id, :receiver_jagent_id => r.jagent_id )
      ReviewMailer.comment_agent_mail(@review,@comment,current_user).deliver!
      redirect_to [@review], :notice => 'Thanks for your comment, will be will reviewed by our customer support soon'
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
