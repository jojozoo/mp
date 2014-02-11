class SessionsController < ApplicationController
  layout 'sign', except: :index

  def index

  end

  # GET /sign_in 登录
  def new
    redirect_to root_path if sign_in?
    @user = User.new
    @errors = {}
  end

  # POST /sign_in 登录
  def create
    @user = User.where(["username = ? or email = ?", params[:username], params[:username]]).first
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
      # 为oauth 登陆添加部分
      param = params[:user].slice(:username, :email, :password, :password_confirmation, :province, :city, :resume, :domain, :gender, :site, :realname, :duty)
      @user = User.new(param)

      
      @user.avatar = begin if params[:avatar].present?
        open(URI.parse(params[:avatar])) rescue nil
      else
        avatar_path = "/tmp/#{SecureRandom.hex(20)}.jpg"
        avatar_name = params[:user][:username].last
        system("convert -size 300x300 -background '#269abc' -fill '#fff' -font public/fonts/zh.ttf -pointsize 300 -gravity center label:'#{avatar_name}' #{avatar_path}")
        @user.avatar = File.open(avatar_path)
      end
      rescue => e
        logger.info("user create avatar error: #{e.to_s}")
        nil
      end
      if @user.save!
        set_sign_in_flag(@user.id)
        # 如果第三方登陆
        if params[:uid].present? and account = Account.find_by_id_and_uid(params[:a_id], params[:uid])
          account.update_attributes!(user_id: @user.id)
          redirect_to root_path
        else
          redirect_to '/validate'
        end
      else
        # TODO 如果oauth登陆, 应该添加remote valid 这是个bug
        render action: :sign_up
      end
    end
  end

  # 验证邮箱
  def validate

  end

  # 忘记密码
  def forgot
    redirect_to root_path if sign_in?
    if request.post?
      if @user = User.where(["username = ? or email = ?", params[:login], params[:login]]).first
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
