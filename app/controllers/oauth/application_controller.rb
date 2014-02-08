require 'oauth2'
class Oauth::ApplicationController < ApplicationController
    layout 'sign'
    before_filter :oauth

    def oauth
        @oauthsite = {'qzone' => '腾讯QQ', 'weibo' => '新浪微博', 'renren' => '人人网', 'douban' => '豆瓣网'}
        YAML.load_file('config/oauth.yml')[controller_name]
    end

    def index
        @account = Account.find_by_id(params[:id])
        redirect_to '/sign_in' and return if @account.blank?
        
        # 如果绑定就跳转
        if @account.user_id.present?
            set_sign_in_flag(@account.user_id)
            redirect_to root_path and return
        end

        # 如果登陆就跳转
        if sign_in?
            @account.update_attributes(user_id: current_user.id) 
            redirect_to root_path and return
        end

        render 'oauth/index'
    end

end