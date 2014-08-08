class SessionsController < ApplicationController

  before_filter :if_sign_redirect, except: [:destroy, :index]
  # 其中 new 和 sign_up 的get请求去掉 路由也去掉 只有首页
  # TODO 有些bug 如登录不成功 或者注册时的验证
  def index
    # render layout: false
    redirect_to home_path
  end

  def sign_in
  end

  def sign_up
    
  end

  # POST /sign_in 登录
  def create
    username = params[:user][:username]
    @user = User.where(["username = ? or email = ? or mobile = ?", username, username, username]).first
    if @user.blank?
      redirect_to sign_in_path and return
    end
    unless @user.valid_password?(params[:user][:password])
      redirect_to sign_in_path and return
    end
    set_sign_in_flag(@user.id)
    redirect_to params[:redirect] || home_path
  end

  # POST /sign_up_p 注册
  def sign_up_p
    # 为oauth 登录添加部分
    # , :password_confirmation
    param = params[:user].slice(:username, :email, :password, :province, :city, :resume, :domain, :gender, :site, :duty, :mobile)
    @user = User.new(param)

    if @user.save!
      # set_sign_in_flag(@user.id)
      # 如果第三方登录
      if params[:uid].present? and account = Account.find_by_id_and_uid(params[:a_id], params[:uid])
        account.update_attributes!(user_id: @user.id)
        redirect_to root_path
      else
        redirect_to '/verif?callback=sign_in'
      end
    else
      # TODO 如果oauth登录, 应该添加remote valid 这是个bug
      # render action: :sign_up
      redirect_to root_path
    end
  end

  # 验证邮箱 / 忘记密码已发送跳转页
  def verif
    if params[:code].present? and @user = User.find_by_salt(params[:code])
      @user.update_attributes(salt: nil)
    end
  end

  # 忘记密码
  def forgot
    redirect_to home_path if sign_in?
    if request.post?
      if User.forgot_password?(params[:username])
        redirect_to '/verif?callback=forgot' # 已发送
      else
        redirect_to '/forgot?callback=notfound'
      end
    end
  end

  # 重置密码
  def reset
    if params[:code].present? and @user = User.find_by_salt(params[:code])
      if request.post? and params[:password].present?
        @user.update_attributes(password: params[:password], salt: nil)
        redirect_to '/verif?callback=reset' # 重置
      end
    else
      render text: '无效链接', status: 404 and return
    end
  end

  # DELETE /sign_out 退出
  def destroy
    sign_out_keeping_session
    redirect_to sign_in_path
  end

  private
  def if_sign_redirect
    if sign_in?
      # render text: 'not found', status: 404 and return
      redirect_to params[:redirect] || home_path and return
    end
  end

end
