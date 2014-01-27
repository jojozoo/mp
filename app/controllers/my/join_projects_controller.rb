class My::JoinProjectsController < My::ApplicationController
	
	def index
		redirect_to action: :events
	end

	def events
		@events = @current_user.events.limit(10)
	end
	def groups
		@events = @current_user.events.limit(10)
	end
end