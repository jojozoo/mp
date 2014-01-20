class My::MsgsController < My::ApplicationController

    def index
        @msgs = @current_user.iboxs.paginate(:page => params[:page], per_page: 5).order('id desc')
    end

    def read
    	@msgs = @current_user.reads.paginate(:page => params[:page], per_page: 5).order('id desc')
    	# render index
    end

    def unread
    	@msgs = @current_user.unreads.paginate(:page => params[:page], per_page: 5).order('id desc')
    end

    def notices
    end

end
