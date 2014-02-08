class Oauth::WeiboController < Oauth::ApplicationController
    
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
    
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'], parse: :json)
        token.options[:mode] = :query
        token.options[:param_name] = 'access_token'
        weibo = token.get("/2/users/show.json", :params => {:uid => token.params["uid"]}).parsed

        other = {
            uid:      weibo['id'],
            name:     weibo['screen_name'],
            province: weibo['location'].split(' ')[0],
            city:     weibo['location'].split(' ')[1],
            resume:   weibo['description'],
            domain:   weibo['domain'],
            gender:   weibo['gender'].eql?('m'),
            site:     weibo['url'],
            avatar:   weibo['profile_image_url'],
            other:    weibo
        }

        account               = Account.find_or_create_by_uid_and_site(other[:uid], controller_name)
        account.user_id       = current_user.id if sign_in?
        account.name          = other['name']
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
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/oauth2/authorize', token_url: '/oauth2/access_token')
    end
end