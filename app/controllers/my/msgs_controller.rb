class My::MsgsController < My::ApplicationController

    def index
        @msgs = current_user.newiboxs.paginate(:page => params[:page], per_page: 10).order('id desc')
    end

    def new
        # follows 的 id
        @writers = current_user.fols
        @writers = User.where(['id != ?', current_user.id])
    end

    def write
       @user = User.find(params[:user_id])
       if exisit = current_user.iboxs(@user).first
        redirect_to action: :show, id: @user.id and return
       end
    end

    def create
        if iboxer = User.find_by_id(params[:user_id])
            msg = current_user.send_msg(iboxer, params[:message][:content])
            flash[:notice] = "发送成功"
            redirect_to params[:redirect] || my_msg_path(msg.user_id)
        else
            flash[:error] = "发送失败"
            redirect_to params[:redirect] || my_msgs_path
        end
    end

    def show
        @user = User.find(params[:id])
        @msgs = current_user.iboxs(@user).paginate(:page => params[:page], per_page: 5).order('id desc')
        @msgs.each{|m| m.update_attributes(state: 1)}
        # current_user.update_attributes(messages_count: current_user.unreads(:refresh).size)
    end

    def notices
        
    end

    def destroy
        if @talk = current_user.iboxs.find_by_id(params[:id])
            if params[:mid].present?
                @talk.inners.find_by_id(params[:mid]).update_attributes(del: true)
            else
                @talk.update_attributes(del: true)
            end
        end
        redirect_to :back
    end

end
