class Admin::CommentsController < AdminController
  before_filter :load_review
	#load_and_authorize_resource

  def create
      @comment = @review.comments.new(comment_params)
      @comment.user_id = current_user.id
      if current_user.role == "jagent"
        m = MonitorJagent.find_or_create_by_review_id(@review.id)
        ReviewMailer.assignee_mail(@review,@comment).deliver!
        m.s_comment = true
      else
        @comment.ispublished = true
      end 
    
      if @comment.save && !params["comment"]["supplier_id"].nil?
        unless current_user.role == "jagent"
          ReviewMailer.comment_mail(@review,@comment).deliver!
        end
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
    if current_user.role == "jagent"
      m = MonitorJagent.find_or_create_by_review_id(@review.id)
      ReviewMailer.review_comment_mail(@review.jagent, @review.agent, @review.ticket_number).deliver!
      m.c_comment = true
      m.save
      @comment.modified_comment = params["comment"]["modified_comment"]
    else
      if @comment.user_id
        uid = @comment.user_id
      else
        uid = current_user.id
      end
      @jagent = User.select(:id,:role).where('id = ?', uid).first
      if @jagent.role == "jagent" || @jagent.role == "agent"
        # unless @comment.modified_comment == params["comment"]["modified_comment"]
          @comment.admin_sagent_comment = true
        # end
      end
      @comment.modified_comment = params["comment"]["modified_comment"] if params["comment"]
      @comment.ispublished = true if params[:commit] == "Publish"
    end
    if @comment.save
       unless current_user.role == "jagent"
          ReviewMailer.comment_mail(@review,@comment).deliver!
        end
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
    params.require(:comment).permit(:title, :user_id, :review_id, :supplier_id,:modified_comment)
  end
end
