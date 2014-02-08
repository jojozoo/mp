class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :site_config, :current_user

  helper_method :current_user, :sign_in?

  def site_config
    @title ||= $site_config[:title]
    @keywords ||= $site_config[:keywords]
    @description ||= $site_config[:description]
    $navs = YAML.load_file("config/datas/global_nav.yml")
  end

  def sign_in?
    !!current_user
  end

  def must_login
    redirect_to '/sign_in' unless sign_in?
  end

  def current_user
  	@current_user ||= sign_in_from_session
  end

  #从session登陆
  def sign_in_from_session
    @current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  #设置登陆状态
  def set_sign_in_flag(user_id)
    session[:user_id] = user_id
  end
  #登出，不重新生成session
  #NOTICE 不是一种安全的策略，session泄露一次账户就会被永久劫持
  def sign_out_keeping_session
    @current_user = nil
    session[:user_id] = nil
  end

end
