module ApplicationHelper

  # 转换时间为友好格式
  def humanize(date)
    p = Time.now - date
    return case
    when p <= 2.minutes then '刚刚'
    when p > 2.minutes && p <= 1.hour then "#{p.to_i / 60} 分钟前"
    when p > 1.hour && date.today? then "今天 #{date.strftime("%H:%M")}"
    when p > 1.hour && date.to_date == Date.yesterday then "昨天 #{date.strftime("%H:%M")}"
    when p > 1.hour && date.to_date < Date.yesterday then date.strftime("%m-%d %H:%M")
    end
  end

  def link_to_push_laud

  end

  def link_to_push_like

  end

  def link_to_push_store

  end

  def link_to_push_recom
    
  end

  def link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options['href'] ||= url

    content_tag(:a, name || url, html_options, &block)
  end

end
