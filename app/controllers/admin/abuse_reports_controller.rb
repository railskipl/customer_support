class Admin::AbuseReportsController < ApplicationController
    layout "admin"
    before_filter :authenticate_user!
	before_action :set_abuse, :only => [:show, :destroy]
	before_action :default_tab

	def index
		@abuse_reports = AbuseReport.find(:all, :order=>"created_at desc")
	end
	
	def new
		if params[:user_id].present?
          @user = User.select(:id,:first_name,:last_name,:email).where('id = ?',params[:user_id]).first
        end

        if params[:comment_id].present?
        	@comment = Comment.select(:id,:name, :email).where('id = ?', params[:comment_id]).first
        end
     
		@abuse_report = AbuseReport.new
	end

	def create
		@abuse_report = AbuseReport.new(abuse_params)
		if @abuse_report.save
			ReviewMailer.abuse_report_mail(@abuse_report).deliver!
			flash[:notice] = "Mail has been sended successfully."
			redirect_to admin_abuse_reports_path
		else
			render :new
		end
	end

	def destroy
		@abuse_report.destroy
		flash[:notice] = "Mail deleted successfully."
		redirect_to admin_abuse_reports_path
	end

	private
	  def abuse_params
	  	params.require(:abuse_report).permit(:user_email,:message,:first_name,:last_name,:subject)
	  end

	  def set_abuse
	  	@abuse_report = AbuseReport.find(params[:id])
	  end

	  def default_tab
	  	@active_tab = 'abuse_reports'
	  end
end
