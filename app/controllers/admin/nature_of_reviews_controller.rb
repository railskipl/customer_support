class Admin::NatureOfReviewsController < AdminController
  before_action :set_nature_of_review, only: [:show, :edit, :update, :destroy]
  before_action :default_tab
  before_action :new_nature_of_review, :only => [:create]

  load_and_authorize_resource

  def new_nature_of_review
    @nature_of_review = NatureOfReview.new(nature_of_review_params)
  end

  # GET /nature_of_reviews
  # GET /nature_of_reviews.json
  def index
    @nature_of_reviews = NatureOfReview.all
  end

  # GET /nature_of_reviews/1
  # GET /nature_of_reviews/1.json
  def show
  end

  # GET /nature_of_reviews/new
  def new
    @nature_of_review = NatureOfReview.new
  end

  # GET /nature_of_reviews/1/edit
  def edit
  end

  # POST /nature_of_reviews
  # POST /nature_of_reviews.json
  def create
    respond_to do |format|
      if @nature_of_review.save
        format.html { redirect_to [:admin,@nature_of_review], notice: 'Nature of review was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /nature_of_reviews/1
  # PATCH/PUT /nature_of_reviews/1.json
  def update
    respond_to do |format|
      if @nature_of_review.update(nature_of_review_params)
        format.html { redirect_to [:admin,@nature_of_review], notice: 'Nature of review was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /nature_of_reviews/1
  # DELETE /nature_of_reviews/1.json
  def destroy
    @nature_of_review.destroy
    respond_to do |format|
      format.html { redirect_to admin_nature_of_reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nature_of_review
      @nature_of_review = NatureOfReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nature_of_review_params
      params.require(:nature_of_review).permit(:title, :user_id, :review_type)
    end

    def default_tab
    	@active_tab = 'nature_of_reviews'
    end
end
