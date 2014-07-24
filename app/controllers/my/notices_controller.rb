class My::NoticesController < My::ApplicationController
	def index
		@notices = current_user.notices.paginate(:page => params[:page], per_page: 20).order('id desc')
	end

	def update
		@notice = current_user.notices.find(params[:id])
	end

	def show
		@notice = current_user.notices.find(params[:id])
	end

	def destroy
		@notice = current_user.notices.find(params[:id])
		@notice.update_attributes(del: true)
		redirect_to :back
	end

end
