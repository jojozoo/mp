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
  def link_to_tui name, obj, isblock = true

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
        link_to "<i class='icon-envelope'></i> 私信".html_safe, "/ajax/msg/user/#{user_id}", class: 'btn btn-default btn-xs btn-msg'
      end
    else
      link_to "<i class='icon-envelope'></i> 私信".html_safe, 'javascript:void(0);', class: 'btn btn-default btn-xs btn-msg mp-sign'
    end
  end

  def link_to_like
  end

  def link_to_store
  end

  def link_to_recommend
  end

  def link_to_choice
  end

  def link_to_original
  end

  def link_to_destroy
  end

  def sessionbackgrounds
    url = ["1679091c5a.jpg", "45c48cce2e.jpg", "8f14e45fce.jpg", "a87ff679a2.jpg", "c4ca4238a0.jpg", "c81e728d9d.jpg", "c9f0f895fb.jpg", "eccbc87e4b.jpg"].sort_by{rand}[0]
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

  def link_to_photo photo
    url = (photo.isgroup and photo.parent_id.nil?) ? photo_path(photo, sid: photo.id, sn: 'group') : photo_path(photo, sid: photo.user_id)
    link_to image_tag(photo.picture(:thumb)), url, target: '_blank', class: 'thumb'
  end

end
