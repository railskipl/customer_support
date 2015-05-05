class Admin::CommentsController < AdminController
  before_filter :load_review
	#load_and_authorize_resource

  def create
      @comment = @review.comments.new(comment_params)
      @comment.user_id = current_user.id
      if current_user.role == "jagent"
        m = MonitorJagent.find_or_create_by_review_id(@review.id)
        # ReviewMailer.delay.assignee_mail(@review,@comment)
        m.s_comment = true
      else
        @comment.ispublished = true
      end 
    
      if @comment.save && !params["comment"]["supplier_id"].nil?
        unless current_user.role == "jagent"
          ReviewMailer.delay.company_comment_mail(@review,@comment)
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
      # ReviewMailer.delay.review_comment_mail(@review.jagent, @review.agent, @review.ticket_number)
      m.c_comment = true
      m.comment_status = "Waiting for approval"
      m.save
      n = @comment.notification
      n.comment_status = "Waiting for approval"
      n.save
      @comment.modified_comment = params["comment"]["modified_comment"] if params["comment"]
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
      
      if params[:commit] == "Publish"
        @comment.ispublished = true 
        m = @review.monitor_jagent
        m.comment_status = "Published"
        m.save
        n = @comment.notification
        n.comment_status = "Published"
        n.save
      end
    end
    if @comment.save
        unless current_user.role == "jagent"
          ReviewMailer.delay.comment_mail(@review,@comment)
          ReviewMailer.delay.other_comment_mail(@review,@comment)
        end
      redirect_to [:admin,@review], :notice => 'Comment has sucessfully Saved.'
    else
      redirect_to [:admin,@review], :alert => 'Error in Comment publishing .'
    end
  end

  def unpublished
    comment = Comment.find(params[:comment_id])
    comment.ispublished = false
    comment.save
    ReviewMailer.delay.comment_unpublish_mail(@review,comment)
    redirect_to :back
  end


  private
  def load_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :user_id, :review_id, :supplier_id,:modified_comment)
  end
end

