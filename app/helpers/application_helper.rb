module ApplicationHelper

  def markdown(text)
    options = {   
        :autolink => true, 
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
      }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
    markdown.render(h(text)).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
    end
  end

  # 转换时间为友好格式
  def humanize(from_time)
    from_time = from_time || Time.now
    to_time = Time.now
    distance_in_minutes = (((to_time - from_time).abs) / 60).round
    distance_in_seconds = ((to_time - from_time).abs).round
    case distance_in_minutes
    when 0..1
     case distance_in_seconds
       when 0..4   then '不到5秒'
       when 5..9   then '不到10秒'
       when 10..19 then '不到20秒'
       when 20..39 then '大约半分钟'
       when 40..59 then '不到一分钟'
       else             '一分钟'
     end
    when 2..59           then "#{distance_in_minutes} 分钟前"
    when 60..1439        then "今天 #{from_time.strftime("%H:%M")}" # "大约 #{(distance_in_minutes.to_f / 60.0).round} 小时"
    when 1440..2879      then "昨天 #{from_time.strftime("%H:%M")}"
    else                     from_time.strftime("%m-%d %H:%M")
    end
  end

  # TODO 重写remote js diabled时不请求
  def link_to_tui name, obj, isblock = true

  end

  def lin_to_fol_j user_id
    if current_user
      unless current_user.id == user_id
        if current_user.fol?(user_id)
          link_to '取消关注', ajax_fol_path('user', user_id), class: 'tofol btn-fold mp-ajax-fol'
        else
          link_to '+关注', ajax_fol_path('user', user_id), class: 'tofol mp-ajax-fol'
        end
      end
    else
      link_to '+关注', 'javascript:void(0);', class: 'tofol mp-sign'
    end
  end
  
  def link_to_fol user_id
    if current_user
      unless current_user.id == user_id
        if current_user.fol?(user_id)
          link_to '取消关注', ajax_fol_path('user', user_id), class: 'btn btn-primary btn-xs btn-fol btn-fold mp-ajax-fol'
        else
          link_to '关注', ajax_fol_path('user', user_id), class: 'btn btn-primary btn-xs btn-fol mp-ajax-fol'
        end
      end
    else
      link_to '关注', 'javascript:void(0);', class: 'btn btn-primary btn-xs btn-fol mp-sign'
    end
  end

  def link_to_msg user_id
    if current_user
      unless current_user.id == user_id
        link_to "<i class='icon-envelope'></i> 私信".html_safe, "/ajax/msg/user/#{user_id}", class: 'btn btn-default btn-xs btn-msg', remote: true
      end
    else
      link_to "<i class='icon-envelope'></i> 私信".html_safe, 'javascript:void(0);', class: 'btn btn-default btn-xs btn-msg mp-sign'
    end
  end

  def link_to_share type, photo
    title = photo.title.to_s + ' - mpwang.cn（漫拍网摄影作品分享）'
    desc = photo.desc
    url = photo_url(photo, sf: type)
    images = if photo.isgroup and photo.parent_id.nil? and gl = Photo.find_by_id(photo.gl_id)
      gl.picture.url(:large)
    else
      photo.picture.url(:large)
    end
    case type
    when 'qq'
    when 'weibo'
      p = {
        appkey: 3912918179,
        url: url,
        title: title,
        source: '',
        sourceUrl: '',
        pic: images,
        content: 'utf-8'
      }.to_param
      "http://service.weibo.com/share/share.php?#{p}".html_safe
    when 'qzone'
      p = {
        url: url,
        # to: 'qzone',
        desc: '',
        summary: desc,
        title: title,
        site: 'mpwang.cn',
        pics: images
      }.to_param
      "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?#{p}".html_safe
    when 'tx'

    when 'weixin'

    when 'renren'
    p = {
      resourceUrl: url, #分享的资源Url
      # srcUrl: url,  # 分享的资源来源Url,默认为header中的Referer,如果分享失败可以调整此值为resourceUrl试试
      pic: images,   # 分享的主题图片Url
      title: title,                   # 分享的标题
      description: desc  # 分享的详细描述
    }.to_param
    "http://widget.renren.com/dialog/share?#{p}".html_safe
    when 'douban'
      p = {
        image: images,
        name: title,
        text: desc,
        href: url
      }.to_param
      "http://www.douban.com/share/service?#{p}".html_safe
    else

    end
  end

  def sessionbackgrounds
    url = ["1679091c5a.jpg", "45c48cce2e.jpg", "8f14e45fce.jpg", "c9f0f895fb.jpg"].sort_by{rand}[0]
    "/images/backgrounds/#{url}?1394877273"
  end

  def time_style time
    de = time.to_date.to_s
    sx = case time.strftime("%H").to_i
    when 0..12
      '（上午）'
    when 13..18
      '（下午）'
    when 18..23
      '（晚上）'
    else
      '（上午）'
    end

    zj = case time.wday
    when 0
      '天'
    when 1
      '一'
    when 2
      '二'
    when 3
      '三'
    when 4
      '四'
    when 5
      '五'
    else
      '六'
    end
    de + sx + "【星期#{zj}】"
  end

  def link_to_large photo
    if photo.isgroup and photo.parent_id.blank? and gl = Photo.find_by_id(photo.gl_id)
      link_to image_tag('/images/default_load_photo.gif', 'data-original' => gl.picture.url(:large), class: 'lazy'), photo_path(photo.id), target: '_blank', title: '点击查看详细内容'
    else
      link_to image_tag('/images/default_load_photo.gif', 'data-original' => photo.picture.url(:large), class: 'lazy'), photo_path(photo.id), target: '_blank', title: '点击查看详细内容'
    end
  end

  def link_to_photo photo, glass = 'thumb'
    if photo.isgroup and photo.parent_id.blank? and gl = Photo.find_by_id(photo.gl_id)
      link_to image_tag(gl.picture(:cover)), photo_path(photo.id), target: '_blank', class: glass
    else
      link_to image_tag(photo.picture(:cover)), photo_path(photo.id), target: '_blank', class: glass
    end
  end

  def link_to_goon photo
    if photo.isgroup and photo.parent_id.present?
      link_to '继续上传', complex_photos_path(go_id: photo.parent_id), class: 'opt'
    else
      link_to '继续上传', complex_photos_path(go_id: photo.id), class: 'opt'
    end
  end

end
