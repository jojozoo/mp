class Admin::SessionsController < Admin::ApplicationController
  
  def index
    @users = User.paginate(:page => params[:page], per_page: 3).order(params[:order])
  end

  # GET /sign_in 登录
  def new
    
  end

  # POST /sign_in 登录
  def create

  end

  # GET /sign_up 注册
  # 真正注册在node方面(因为涉及发邮件)
  def sign_up

  end

  def validate
  end

  # DELETE /sign_out 退出
  def destroy

  end
	
end

