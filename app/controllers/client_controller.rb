class ClientController < ApplicationController

	def index
		@projects = Project.where(:user_id => current_user.id)
		@project= Project.where(:user_id => current_user.id,:project_status => 1)
		@projects_alloted = Project.where(:user_id => current_user.id,:project_status => 3)
	end

	def all_bidding_page
	end
	def project_display_page
		@project=Project.find(params[:project_id])
		@client_preference = ClientPreference.new
		@startup
		if @project.project_status.id == 3
			
			@startupid=StartupProject.where(:project_id => params[:project_id]).first.user_id
			@startup = User.find(@startupid)
			@install = @startup.bids.where(:project_id => params[:project_id]).first.installments
			@techno = Project.find(params[:project_id]).technology
			
		end

		@connections = Connection.where(:user_id => current_user.id)
		@requested_connections = RequestConnection.where(:user_id => current_user.id )
		@request_connection_new = RequestConnection.new
		@connection_new = Connection.new



	end
	def project_display_page_2
		@client_preference = ClientPreference.new
		@project_id =2
	end

	def connections_client
		@connections = Connection.where(:user_id => current_user.id)
		@users = User.where(:id => @connections.select(:startup_id))
		@all_ids = Project.where(:user_id => current_user.id).select(:id)
		@connection_new = Connection.new
		
	end

	def history_page
		@completed_projects = Project.where(:user_id => current_user.id,:project_status_id => 4)
		
	end

end
