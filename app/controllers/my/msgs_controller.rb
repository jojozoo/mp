class My::MsgsController < My::ApplicationController

    def index
        @talks = @current_user.iboxs.paginate(:page => params[:page], per_page: 5).order('id desc')
    end

    def read
    	@talks = @current_user.reads.paginate(:page => params[:page], per_page: 5).order('id desc')
    	render 'index'
    end

    def unread
    	@talks = @current_user.unreads.paginate(:page => params[:page], per_page: 5).order('id desc')
        render 'index'
    end

    def show
        @talk = @current_user.iboxs.find(params[:id])
    end

    def notices
    end

end
