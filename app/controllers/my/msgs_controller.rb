class My::MsgsController < My::ApplicationController

    def index
        @msgs = @current_user.iboxs.paginate(:page => params[:page], per_page: 10).order('id desc')
    end

    def read
    end

end