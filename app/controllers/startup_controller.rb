class StartupController < ApplicationController

	def index
		technologies = []
		current_user.technologies.each do |technology|
			technologies << technology.id 

		end

    @projects = Project.where(project_status_id:1,technology_id:technologies)
	
	end

	def project_page
		@project = Project.where(id: params[:project]).first
		
		@installment = Installment.new
		@bid = Bid.new
	end

def job_offer

	@startups = ClientPreference.where("user_id=? AND startup_status_id =?",current_user.id,4)
	@projects = Project.all;
	@bids = Bid.where(user_id:current_user.id)
	@projects1 = Project.where("project_status_id=? OR project_status_id=?",1,2)
	

	 
	# @client_preference = ClientPreference.where("user_id=? AND project_id",current_user.id,current_user.project)
	
 end
	def request_method
		@client_preference = ClientPreference.where(project_id: params[:project_id], user_id: current_user.id).first 
		if params[:decide]== 'accept'			
			# @array = ClientPreference.where(project_id: params[:project_id], startup_status_id: 1)
			# @array.each do |a|
			# 	a.update_attribute(:startup_status_id,3)
			# end
			@client_preference.update_attribute(:startup_status_id,1)
			@startup_project = StartupProject.new(:project_id => params[:project_id], :user_id => current_user.id)
			@startup_project.save
		else
			@client_preference.update_attribute(:startup_status_id,2)
			@temp = @client_preference.id + 1
			if ClientPreference.find(@temp).project_id == params[:project_id]
				@client_preference = ClientPreference.find(@temp)
				@client_preference.update_attribute(:startup_status_id,4)
			else
				# dubara project post karna hai
			end	
		end
		
		respond_to do |format|
	        format.html { redirect_to :controller => 'startup', :action => 'job_offer'}
    	end
	end

 def startup_params
      params.permit(:decide, :project_id)
    end



end
