class My::UsersController < My::ApplicationController
	def index
		redirect_to action: :follows
	end

	def fans
		@users = current_user.followers.paginate(:page => params[:page], per_page: 10)
	end

	def follows
		@users = current_user.follows.paginate(:page => params[:page], per_page: 10)
	end
end