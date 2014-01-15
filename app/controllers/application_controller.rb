class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :site_config, :current_user

  def site_config
    @title ||= $site_config[:title]
    @keywords ||= $site_config[:keywords]
    @description ||= $site_config[:description]
  end

  def current_user
  	@current_user = User.first
  end
end
