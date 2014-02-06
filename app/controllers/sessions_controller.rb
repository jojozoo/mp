class SessionsController < ApplicationController
  layout 'sign', except: :index

  def index

  end

  # GET /sign_in 登录
  def new
    redirect_to root_path if @current_user
    @user = User.new
    @errors = {}
  end

  # POST /sign_in 登录
  def create
    @user = User.where(["username = ? or email = ? or mobile = ?", params[:username], params[:username], params[:username]]).first
    @errors = {}
    if @user.blank?
      @errors[:username] = "请输入正确的账号/邮箱/手机"
      render action: :new and return
    end
    unless @user.valid_password?(params[:password])
      @errors[:password] = "密码错误"
      render action: :new and return
    end
    set_sign_in_flag(@user.id)
    redirect_to root_path
  end

  # GET /sign_up 注册
  # 真正注册在node方面(因为涉及发邮件)
  def sign_up
    if request.post?
      param = params[:user].slice(:username, :email, :password, :password_confirmation) rescue {}
      @user = User.new(param)
      if @user.save
        set_sign_in_flag(@user.id)
        redirect_to '/validate'
      else
        render action: :sign_up
      end
    end
  end

  # 验证邮箱
  def validate

  end

  # 忘记密码
  def forgot_password
    redirect_to root_path if @current_user
    if request.post?
      if @user = User.where(["username = ? or email = ? or mobile = ?", params[:login], params[:login], params[:login]]).first
        redirect_to action: :validate and return
      else
        @error = "找不到对应账号"
      end
    end
  end

  # DELETE /sign_out 退出
  def destroy
    sign_out_keeping_session
    redirect_to action: :new
  end

end
