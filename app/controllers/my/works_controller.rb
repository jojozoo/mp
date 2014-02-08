 class My::WorksController < My::ApplicationController
 	def index
        @works = current_user.works.paginate(:page => params[:page], per_page: 10).order('id desc')
 	end
 end