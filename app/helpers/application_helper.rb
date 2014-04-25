module ApplicationHelper

  # 转换时间为友好格式
  def humanize(from_time)
    # def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
    # from_time = from_time.to_time if from_time.respond_to?(:to_time)
    # to_time = to_time.to_time if to_time.respond_to?(:to_time)
    # p = Time.now - date
    # return case
    # when p <= 2.minutes then '刚刚'
    # when p > 2.minutes && p <= 1.hour then "#{p.to_i / 60} 分钟前"
    # when p > 1.hour && date.today? then "今天 #{date.strftime("%H:%M")}"
    # when p > 1.hour && date.to_date == Date.yesterday then "昨天 #{date.strftime("%H:%M")}"
    # when p > 1.hour && date.to_date < Date.yesterday then date.strftime("%m-%d %H:%M")
    # end
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
    # when 2880..43199     then "#{(distance_in_minutes / 1440).round} days"
    # when 43200..86399    then 'about 1 month'
    # when 86400..525599   then "#{(distance_in_minutes / 43200).round} months"
    # when 525600..1051199 then 'about 1 year'
    else                     from_time.strftime("%m-%d %H:%M")
    end
  end

  # TODO 重写remote js diabled时不请求
  def link_to_push name, obj, isblock = true
    type, method, icon, str = case name
    when 'like'
      ['likes', 'tuilike?', 'heart', '喜欢']
    when 'store'
      ['stores', 'tuistore?', 'star', '收藏']
    when 'recom'
      ['recoms', 'tuirecom?', 'ok-circle', '推荐']
    else
      ['likes', 'tuilike?', 'heart', '喜欢']
    end
    class_str = "push-#{type}-#{obj.id}-link"
    class_str += isblock ? ' btn btn-success btn-xs' : ''
    if current_user
      if obj.try(method, current_user)
        class_str += ' disabled'
      else
        class_str += ' btn-ajax'
      end
    end
    options = {remote: true, method: :post, class: class_str}
    if isblock
      link_to ajax_tui_path(type, 'image', obj.id), options do
        "<i class='icon-#{icon}'></i>#{str}".html_safe
      end
    else
      options[:class] = options[:class] + " push-#{type}-#{obj.id}-effect"
      link_to str + "(#{obj.try(type + '_count')})", ajax_tui_path(type, 'image', obj.id), options.merge(title: str)
    end
  end

  def link_to_follow user_id, glass = 'btn btn-default btn-xs'
    isglass = glass.eql?('')
    if current_user and current_user.fol?(user_id)
      link_to '取消关注', ajax_ufl_path('user', user_id, isglass: isglass), remote: true, method: :post, class: glass, id: "js-follow-#{user_id}"
    else
      link_to '<i class="icon-plus"></i> 关注'.html_safe, ajax_fol_path('user', user_id, isglass: isglass), remote: true, method: :post, class: glass, id: "js-follow-#{user_id}"
    end
  end

  def userbackground
    # asset_path(Sbg.bgs.order('rand()').first.photo.url)
    '/system/sbgs/5/original/e4da3b7fbb.jpg?1394877293'
  end
  def signsbackground
    Sbg.signs.order('rand()').first.photo.url
    # ["/system/sbgs/1/original/c4ca4238a0.jpg?1394877196", "/system/sbgs/2/original/c81e728d9d.jpg?1394877228", "/system/sbgs/3/original/eccbc87e4b.jpg?1394877242", "/system/sbgs/4/original/a87ff679a2.jpg?1394877273"].sort_by{rand}[0]
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

end
