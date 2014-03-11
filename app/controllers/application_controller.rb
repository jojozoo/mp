class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :site_config, :current_user

  helper_method :current_user, :sign_in?

  def site_config
    @title ||= $site_config[:title]
    @keywords ||= $site_config[:keywords]
    @description ||= $site_config[:description]
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

  #从session登录
  def sign_in_from_session
    @current_user = User.find_by_id(session[:user_id]) if session[:user_id]
  end

  #设置登录状态
  def set_sign_in_flag(user_id)
    session[:user_id] = user_id
  end
  #登出，不重新生成session
  #NOTICE 不是一种安全的策略，session泄露一次帐户就会被永久劫持
  def sign_out_keeping_session
    @current_user = nil
    session[:user_id] = nil
  end

  def default_url_options(options={})
  # logger.debug "default_url_options is passed options: #{options.inspect}\n"
  # { :env => 'dev' }
  {}
  end

  # 生成手机验证码
  def mobile_captcha(session_name,mobile)
    session_name = session_name.to_sym
    session[session_name] = {}
    session[session_name][:mobile] = mobile
    session[session_name][:captcha] = ''
    session[session_name][:expire_at] = 5.minutes.from_now
    session[session_name][:expire_times] = 5
    1.upto(4){session[session_name][:captcha].push(rand(10).to_s)}
    logger.info('----------'+mobile+'/'+session[session_name][:captcha])
  end
  
  #发送验证码
  def send_mobile_captcha(mobile)
    mobile_captcha(:join, mobile)
    # i18n 里的join是什么类型的sms
    Sms.send(mobile, I18n.t('sms.join', code: session[:join][:captcha]))
  end

  # 清空手机验证码
  def clear_mobile_captcha(session_name)
    session.delete(session_name.to_sym)
  end
  # 自定义错误页面
  # 由于全面导入Rack的关系
  # 现在的Route其实也是一个Rack middleware
  # 所以RoutingError, ActionNotFound(UnknownAction)不再被当作异常抛出
  # rescue_from Exception, :with => :rescue_action if Rails.env.production?
  # Person.pluck(:id)
  # SELECT people.id FROM people
  # => [1, 2, 3]
  def rescue_action(exception)
    case exception
    when ActiveRecord::RecordNotFound,
        ActionController::RoutingError,
        AbstractController::ActionNotFound
      # CGI.escapeHTML(exception.message)
      # exception.backtrace.join("<br/>")
      @message = "页面不存在。"
      @title = status = '404 Not Found'
      @exception = ("<p>request:#{request.url}</p>").html_safe
    when ActiveRecord::RecordInvalid,
        ActiveRecord::RecordNotSaved,
        ActionController::InvalidAuthenticityToken,
        ActiveRecord::StaleObjectError,
        ActionController::MethodNotAllowed,
        ActionController::NotImplemented
      @message = "该请求无法处理。"
      @title = status = '422 Unprocessable Entity'
    else
      @message = "网站升级，稍候访问。"
      @title = status = '500 Internal Server Error'
      # exception.backtrace.first(10).join("<br/>")
      @exception = @exception = ("<p>request:#{request.url}</p>").html_safe
      # TODO 定制500错误信息，方便日志分析工具统计
      puts error = {
        user_id: current_user_id,
        event:   "#{params[:controller]}##{params[:action]}",
        log:     @exception,
        message: exception.message,
        ip:      request.ip
      }
    end
    # render :template => '/path/error.html.erb', status: status
    render text: @exception, :status => status
  end

end
