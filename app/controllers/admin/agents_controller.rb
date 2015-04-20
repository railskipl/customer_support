class Admin::AgentsController < AdminController
  before_action :default_tab
  before_filter :set_current_user
  #load_and_authorize_resource :class => "User"

  def new_agent
    @agent = User.new(agent_params)
  end

  def index
    if current_user.is? :admin
      @agents = User.all.agents
    else
      @agents = User.where("role = ?","jagent")
    end
  end

  def show
    @agent = User.find(params[:id])
  end

  def new
    @agent = User.new
  end

  def edit
    @agent = User.find(params[:id])
  end
  
  def create
    @agent = User.new(agent_params)
    @agent.role = agent_params["role"]
    @agent.password = rand(36**10).to_s(36)
    password = @agent.password
    if @agent.save
       AgentMailer.delay.agent_mail(@agent,password)
       redirect_to admin_agent_path(@agent), notice: 'Agent was successfully created.'
    else
       render :new
    end
  end

  def update
  @agent = User.find(params[:id])
      if @agent.update(agent_params)
         redirect_to admin_agent_path(@agent), notice: 'agent was successfully updated.'
      else
         render action: 'edit'
      end
  end

  def destroy
    @agent = User.find(params[:id])
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to admin_agents_url }
      format.json { head :no_content }
    end
  end

  private

  def agent_params
    params.require(:agent).permit(:first_name, :last_name, :preferred_alias, :email, :password, :role)
  end

  def default_tab
	  @active_tab = "agents"
  end
end
