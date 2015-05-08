class Admin::PollsController < AdminController
  before_action :default_tab
	before_action :new_poll, :only => [:create]
  load_and_authorize_resource

  def new_poll
    @poll = Poll.new(poll_params)
  end

  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def new
    @poll = Poll.new
    5.times { @poll.options.build }
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def create
    respond_to do |format|
      if @poll.save
        format.html { redirect_to [:admin,@poll], notice: 'Poll was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
  @poll = Poll.find(params[:id])
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to [:admin,@poll], notice: 'Poll was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to admin_polls_url }
      format.json { head :no_content }
    end
  end

  private

  def poll_params
    params.require(:poll).permit(:title, :start_date, :end_date, :published, options_attributes: [:id, :answer, :_destroy])
  end

  def default_tab
	  @active_tab = "polls"
  end

end
