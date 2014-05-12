class Admin::SessionsController < Admin::ApplicationController
  
  def index
    @users = User.paginate(:page => params[:page], per_page: 3).order(params[:order])
  end

  def msg
    if request.post?
      User.all.each do |u|
        current_user.send_msg(u, params[:content])
      end
      flash[:notice] = "发送成功"
    end
  end
  
end

