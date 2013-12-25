class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :site_config

  def site_config
    @title ||= $site_config[:title]
    @keywords ||= $site_config[:keywords]
    @description ||= $site_config[:description]
    @duty = $site_config[:be_on_duty][Date.today.wday]
    @is_duty = $site_config[:be_on_duty_show].eql?('1')
  end
end
