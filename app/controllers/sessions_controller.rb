class SessionsController < ApplicationController

  # 其中 new 和 sign_up 的get请求去掉 路由也去掉 只有首页
  # TODO 有些bug 如登录不成功 或者注册时的验证
  def index
    redirect_to home_path if sign_in?
    session[:url] = params[:redirect] if params[:redirect].present?
  end

  # POST /sign_in 登录
  def create
    @user = User.where(["username = ? or email = ? or mobile = ?", params[:username], params[:username], params[:username]]).first
    if @user.blank?
      redirect_to root_path(m: 'sign_in') and return
    end
    unless @user.valid_password?(params[:password])
      redirect_to root_path(m: 'sign_in') and return
    end
    set_sign_in_flag(@user.id)
    redirect_to params[:redirect] || session.delete(:url) || home_path
  end

  # GET /sign_up 注册
  def sign_up
    # 为oauth 登录添加部分
    param = params[:user].slice(:username, :email, :password, :password_confirmation, :province, :city, :resume, :domain, :gender, :site, :duty)
    @user = User.new(param)
    # @user.avatar = begin if params[:avatar].present?
    #     open(URI.parse(params[:avatar])) rescue nil
    #   else
    #     avatar_path = "/tmp/#{SecureRandom.hex(20)}.jpg"
    #     avatar_name = params[:user][:username].last
    #     system("convert -size 300x300 -background '#269abc' -fill '#fff' -font public/fonts/zh.ttf -pointsize 300 -gravity center label:'#{avatar_name}' #{avatar_path}")
    #     File.open(avatar_path)
    #   end
    # rescue => e
    #   logger.info("user create avatar error: #{e.to_s}")
    #   nil
    # end

    if @user.save!
      set_sign_in_flag(@user.id)
      # 如果第三方登录
      if params[:uid].present? and account = Account.find_by_id_and_uid(params[:a_id], params[:uid])
        account.update_attributes!(user_id: @user.id)
        redirect_to root_path
      else
        redirect_to '/validate'
      end
    else
      # TODO 如果oauth登录, 应该添加remote valid 这是个bug
      # render action: :sign_up
      redirect_to root_path
    end
  end

  # 验证邮箱
  def verif

  end

  # 忘记密码
  def forgot
    redirect_to root_path if sign_in?
    if request.post?
      if @user = User.where(["username = ? or email = ?", params[:login], params[:login]]).first
        @user.update_attribute(:salt, Digest::MD5.hexdigest(Time.now.to_s(:db)))
        redirect_to '/forgotdb'
      else
        @error = "找不到对应帐号"
      end
    end
  end

  # 重置密码
  def reset
    if params[:code].present? and @user = User.find_by_salt(params[:code])
      if request.post? and params[:user][:password].present?
        @user.update_attributes(password: params[:user][:password], salt: nil)
        flash[:notice] = '密码修改成功'
        redirect_to root_path(m: 'sign_in')
      end
    else
      redirect_to '/'
    end
  end

  # DELETE /sign_out 退出
  def destroy
    sign_out_keeping_session
    redirect_to root_path(m: 'sign_in')
  end

end
