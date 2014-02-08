class Oauth::DoubanController < Oauth::ApplicationController
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
        
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        douban = token.get('https://api.douban.com/v2/user/~me').parsed
        addr = douban['loc_name']
        other = {
            uid:      douban['uid'],
            name:     douban['name'],
            province: douban['loc_name'],
            resume:   douban['desc'],
            avatar:   douban['avatar'],
            other:    douban
        }

        account               = Account.find_or_create_by_uid_and_site(other[:uid], controller_name)
        account.user_id       = current_user.id if sign_in?
        account.token         = token.token
        account.refresh_token = token.refresh_token
        account.expires_in    = token.expires_in
        account.expires_at    = token.expires_at
        account.other         = other.to_json
        account.save!
        redirect_to oauth_sign_in_path(id: account.id)
    rescue => e
        logger.info("#{controller_name} account login error #{e.to_s}")
        redirect_to '/sign_in'
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/service/auth2/auth', token_url: '/service/auth2/token')
    end

end