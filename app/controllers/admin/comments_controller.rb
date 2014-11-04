class Admin::CommentsController < AdminController
  before_filter :load_review
	#load_and_authorize_resource

  def create
      @comment = @review.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.ispublished = true
      if @comment.save && !params["comment"]["supplier_id"].nil?
        ReviewMailer.comment_mail(@review,@comment).deliver!
        redirect_to [:admin, @review], :notice => 'Thanks for your comment'
      else
        redirect_to [:admin, @review], :alert => 'Unable to add comment'
      end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

 def update
    @comment =  @review.comments.find(params[:id])
    # if current_user.role == "jagent"
    #   m = MonitorJagent.find_or_create_by_review_id(@review.id)
    #   m.c_comment = true
    # else 
      @comment.ispublished = true
    # end
    if @comment.save
      redirect_to [:admin,@review], :notice => 'Comment has sucessfully Saved.'
    else
      redirect_to [:admin,@review], :alert => 'Error in Comment publishing .'
    end
  end


  private
  def load_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :user_id, :review_id, :supplier_id)
  end
end
