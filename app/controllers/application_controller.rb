class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :site_config, :current_user, :mobile_filter

  helper_method :current_user, :sign_in?

  def mobile_filter
    if request.subdomain.eql?('touch')
      redirect_to request.url.gsub(/touch./, "") and return unless request.user_agent =~ /Mobile|webOS/
    end
    unless request.subdomain.eql?('touch')
      redirect_to request.url.gsub(/mpwang/, "touch.mpwang") and return if request.user_agent =~ /Mobile|webOS/
    end
  end

  def site_config
    @title ||= '漫拍网 - 源自生活的影像'
    @keywords ||= '漫拍,漫拍网,mp,mpwang,图片,摄影,摄影网,摄影师,摄影入门,人像摄影,摄影技巧,摄影论坛,摄影作品,摄影活动,深度摄影,摄影名家,商业摄影,影览,图片分享,照片,照片分享,摄影界'
    @description ||= '漫拍网是一个倡导拍身边人,身边事,身边景的社交网站,用照片记录生活面貌,表现社会发展进程,表达内心感悟.漫即广泛、深远、悠闲,拍即呈现我们身边的影像,让我们一起分享镜头中的精彩.'
  end

  def sign_in?
    !!current_user
  end

  def must_login
    unless sign_in?
      if request.xhr?
        # 弹登录框
      else
        redirect_to sign_in_path(redirect: request.url)
      end and return
    end
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
