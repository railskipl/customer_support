class Admin::ReviewsController < AdminController
	before_action :default_tab
	before_action :get_review , :only => [:show, :edit, :update]
	load_and_authorize_resource :except => [:search_reviews]
  
	def index
		@reviews = Review.unarchived.order("id desc")
	end

  def show

  end

  def edit
    
  end

  def update
    
    if params[:commit] == 'Publish'
      @review.ispublished = true
      @review.published_date = DateTime.now
      @review.archive = false
      respond_to do |format|
        if @review.update(review_params)
          ReviewMailer.publish_mail(@review).deliver!
          ReviewMailer.publish_adminmail(@review, current_user).deliver!
          format.html { redirect_to [:admin,@review], notice: 'Review was successfully published.' }
        else
          format.html { render action: 'edit' }
        end
      end
    elsif params[:commit] == 'Archive-Attachment'
      @review.archive_attachment = true
      respond_to do |format|
        if @review.update(review_params)
          ReviewMailer.archive_mail(@review).deliver! 
          ReviewMailer.archive_adminmail(@review, current_user).deliver!  
          format.html { redirect_to edit_admin_review_path(@review.id), notice: 'Attachment was successfully Archived.' }
        else
          format.html { render action: 'edit' }
        end
      end
    elsif params[:commit] == 'Archive'
      @review.archive = true
      @review.ispublished = false
      respond_to do |format|
        if @review.update(review_params)
          ReviewMailer.archive_mail(@review).deliver!
          ReviewMailer.archive_adminmail(@review, current_user).deliver!
          format.html { redirect_to [:admin,@review], notice: 'Review was successfully Archived.' }
        else
          format.html { render action: 'edit' }
        end
      end
    else
      respond_to do |format|
        if @review.update(review_params)
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

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     respond_to do |format|
       format.html { redirect_to admin_reviews_url }
       format.json { head :no_content }
     end
  end

  def review_params
    params.require(:review).permit(:ispublished, :archive, :title, :industry_id, :company_id, :date, :town_id,:datetime, :location_id, :personal_responsible, :nature_of_review,:message,:account_details,:ticket_number,:user_id, :token_number,:review_type,:file,:is_modified, :modified_review,:notes)
  end

  def default_tab
	  @active_tab = "reviews"
  end
  
  def get_review
    @review ||= Review.find(params[:id])
  end

end
