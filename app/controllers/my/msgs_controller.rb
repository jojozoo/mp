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

    def new
        if params[:to].present? and @to = User.find_by_id(params[:to])
            render 'sendmsg'
        end
    end

    def create
        if iboxer = User.find_by_id(params[:to_id])
            msg = current_user.send_msg(iboxer, params[:message][:text])
            redirect_to my_msg_path(msg.talk_id)
        else
            redirect_to root_path
        end
        
    end

    def show
        @talk = @current_user.iboxs.find_by_id(params[:id])
        redirect_to my_msgs_path unless @talk
        @talk.update_attributes(state: 0)
        @msgs = @talk.messages.where(del: false)
    end

    def notices
        
    end

    def destroy
        if @talk = @current_user.iboxs.find_by_id(params[:id])
            if params[:mid].present?
                @talk.messages.find_by_id(params[:mid]).update_attributes(del: true)
            else
                @talk.update_attributes(del: true)
            end
        end
        redirect_to :back
    end

end
