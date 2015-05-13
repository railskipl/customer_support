class Admin::ReviewsController < AdminController
	before_action :default_tab
	before_action :get_review , :only => [:show, :edit, :update]
	load_and_authorize_resource :except => [:search_reviews,:ticket_closed,:assign_reviews]
  
	def index
     @users = User.where("role = ? or role = ?","jagent","agent")
     if current_user.is? :jagent
		  @reviews = Review.junior_agent(current_user.id)
     else
       # @reviews = Review.where("(jagent_id = ? or old_jagent_id = ?) and published_date is null",current_user.id,current_user.id).unarchived.where("user_id is not null").order("id desc")
     end
    @areviews = Review.unarchived.where("published_date is null and jagent_id is null and user_id is not null").order("id desc")
    @reareviews = Review.unarchived.where("jagent_id is not null and user_id is not null").order("id desc")
	end

  def show
    @review_note = ReviewNote.new
    @review_notes = @review.review_notes
  end

  def archive_reviews
    @active_tab = "archive_reviews"
    @archived_reviews = Review.archived.where('user_id is not null').order("created_at desc")
    @archived_attachments ||= Review.where('archive_attachment = ? and user_id is not null',true)
  end

  def archive_files
    @archived_attachments ||= Review.where('archive_attachment = ? and user_id is not null',true)
  end

  def assign_reviews
    if params["review_ids"].nil? || params["user_id"].nil?
      redirect_to admin_reviews_url, :notice => "Unable to assign"
    else
      if params["reassign"] == "yes"
        reviews = params["review_ids"]
        reviews.each do |r|
          a = Review.find(r)
          a.old_jagent_id = a.jagent_id
          a.old_agent_id = a.agent_id
          @track_time = TrackTime.where('review_id = ?',r).first
          if @track_time.present?
            @track_time.update(:review_id => r,:date_proposed => params[:date1], :user_id => params[:user_id],:date_complete => nil)
          else
            TrackTime.find_or_create_by_review_id(:review_id => r,:date_proposed => params[:date1], :user_id => params[:user_id])
          end
          a.jagent_id = params[:user_id]
          a.agent_id = params[:agent_id]
          a.save
        end
      else
        reviews = params["review_ids"]
        reviews.each do |r|
          a = Review.find(r)
          TrackTime.find_or_create_by_review_id(:review_id => r,:date_proposed => params[:date], :user_id => params[:user_id])
          a.jagent_id = params[:user_id]
          a.agent_id = params[:agent_id]
          a.save
          m = MonitorJagent.find_or_create_by_review_id(a.id)
          m.status = "Pending"
          m.save
        end
      end
      redirect_to admin_reviews_url
    end
  end

  def edit
    
  end

  def ticket_closed
    review = Review.find(params["review_id"])
    m = MonitorJagent.find_or_create_by_review_id(review.id)
    m.ticked_closed_by_jagent = true
    m.save
    if current_user.role == "admin" || current_user.role == "agent"
      review.is_ticket_open = false
      review.save
      ReviewMailer.delay.ticket_closed_notification(review)
      redirect_to :back, :notice => "Ticket closed successfully"
    else
      redirect_to :back, :notice => "Send Ticket For Review"
    end
  end

  def update
    if params[:commit] == 'Publish'
      @review.ispublished = true
      @review.published_date = DateTime.now
      @review.archive = false
      @review.last_published_agent_id = current_user.id
      t = TrackTime.find_by_review_id(@review.id)
      if t.nil?
        TrackTime.create(:review_id => @review.id,:date_proposed => Time.now ,:date_complete => Time.now,:user_id => current_user.id,:direct_processed => true, :direct_user_id =>current_user.id)
      else
        t.update(:direct_processed => true,:direct_user_id => current_user.id)
      end
      if @review.jagent_id.present?
         m = MonitorJagent.find_or_create_by_review_id(@review.id)
         m.status = "Published"
         m.modified_review = (m.modified_review.nil? ? true : m.modified_review)
         if @review.jagent_id == current_user.id
           m.assign_modified = @review.is_modified? ? true : false
         else
           m.assignee_modified = @review.is_modified? ? true : false
         end
         m.save
        unless @review.modified_review == params[:review][:modified_review]
          @review.admin_sagent_modified = true
        end

        if @review.modified_review.blank? and params[:review][:modified_review].present?
          @review.admin_sagent_modified = true
        end
      else
         m = MonitorJagent.find_or_create_by_review_id(@review.id)
         m.status = "Published"
         m.assignee_modified = @review.is_modified? ? true : false
         m.modified_review = (m.modified_review.nil? ? true : m.modified_review)
         m.save
      end

      respond_to do |format|
        if @review.update(review_params)
          ReviewMailer.delay.publish_mail(@review)
          # ReviewMailer.delay.publish_adminmail(@review, current_user)
          format.html { redirect_to [:admin,@review], notice: 'Review was successfully published.' }
        else
          format.html { render action: 'edit' }
        end
      end
    elsif params[:commit] == 'Archive-Attachment'
      @review.archive_attachment = true unless current_user.role == "jagent"
      respond_to do |format|
        if @review.update(review_params)
          @subject = "Your attachment was not published"
          ReviewMailer.archive_mail(@review,@subject).deliver!  
          format.html { redirect_to edit_admin_review_path(@review.id), notice: 'Attachment was successfully Archived.' }
        else
          format.html { render action: 'edit' }
        end
      end
    elsif params[:commit] == 'Archive'
      m = MonitorJagent.find_or_create_by_review_id(@review.id)
      m.status = "archive"
      m.save
      unless current_user.role == "jagent"
        @review.archive = true 
        @review.ispublished = false
        @review.published_date = nil
      end
      respond_to do |format|
        if @review.update(review_params)
           @subject = "Your review was not published"
           ReviewMailer.archive_mail(@review,@subject).deliver!
          # ReviewMailer.archive_adminmail(@review, current_user).deliver!
          format.html { redirect_to [:admin,@review], notice: 'Review was successfully Archived.' }
        else
          format.html { render action: 'edit' }
        end
      end
    else
      respond_to do |format|
        if @review.update(review_params)
          @track_time = TrackTime.find(@review.track_times.first.id)
          @track_time.update(:date_complete => Date.today)
          m = MonitorJagent.find_or_create_by_review_id(@review.id)
          m.modified_review = true
          if @review.jagent_id == current_user.id
           m.assign_modified = @review.is_modified? ? true : false
          else
           m.assignee_modified = @review.is_modified? ? true : false
          end
          m.status = "Waiting for approval" if !(m.status == "Published")
          m.save
          format.html { redirect_to [:admin,@review], notice: 'Review successfully updated.'}
        else
          format.html { render action: 'edit' }
        end
      end
    end

  end
    def search_reviews
    @reviews = []
    if params[:town_id]
      town = Town.find(params[:town_id])
      @reviews = town.reviews if town 
    elsif params[:supplier_id]
      supplier = Supplier.find(params[:supplier_id])
      comments = supplier.comments
      @reviews = []
      comments.each do |comment|
        @reviews << comment.review  
      end
    elsif params[:location_id]
      location = Location.find params[:location_id]
      @reviews = location.reviews if location 
    elsif params[:company_id]
      company = Company.find params[:company_id]
      @reviews = company.reviews if company
    elsif params[:review_type]
      @reviews = @reviews.where("review_type=?",params[:review_type])
    end
  end

  def unpublished
    review = Review.find(params[:review_id])
    review.ispublished = false
    review.published_date = nil
    review.archive = true
    review.save
    m = MonitorJagent.find_or_create_by_review_id(review.id)
    m.status = "archive"
    m.save
    ReviewMailer.delay.review_unpublish_mail(review)
    redirect_to  archive_reviews_admin_reviews_path , :notice => "Review archived"
  end

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     respond_to do |format|
       format.html { redirect_to admin_reviews_url }
       format.json { head :no_content }
     end
  end

  def review_params
    params.require(:review).permit(:ispublished, :old_agent_id,:archive, :title, :industry_id, :company_id, :date, :town_id,:datetime, :location_id, :personal_responsible, :nature_of_review,:message,:account_details,:ticket_number,:user_id, :token_number,:review_type,:file,:is_modified, :modified_review,:notes)
  end

  def default_tab
	  @active_tab = "reviews"
  end
  
  def get_review
    @review ||= Review.find(params[:id])
  end

end
