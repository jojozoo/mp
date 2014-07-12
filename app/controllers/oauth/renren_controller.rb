class Oauth::RenrenController < Oauth::ApplicationController

    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
        
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        token.options[:mode] = :query
        token.options[:param_name] = 'access_token'
        renren = token.get("https://api.renren.com/v2/user/get", :params => {'userId' => token.params['user']['id']}).parsed
        renren = renren['response']

        other = {
            uid:      renren['id'],
            realname: renren['name'],
            name:     renren['name'],
            province: renren['basicInformation']['homeTown']['province'],
            city:     renren['basicInformation']['homeTown']['city'],
            gender:   renren['basicInformation']['sex'].eql?('MALE'),
            duty:     renren['basicInformation']['birthday'],
            avatar:   renren['avatar'][-1]['url'],
            other:    renren
        }

        account               = Account.find_or_create_by_uid_and_site(other[:uid], controller_name)
        account.user_id       = current_user.id if sign_in?
        account.name          = other['name']
        account.token         = token.token
        account.refresh_token = token.refresh_token
        account.expires_in    = token.expires_in
        account.expires_at    = token.expires_at
        account.other         = other
        account.save!
        redirect_to oauth_sign_in_path(id: account.id)
    rescue => e
        logger.info("#{controller_name} account login error #{e.to_s}")
        redirect_to '/sign_in'
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/oauth/authorize', token_url: '/oauth/token')
    end
    
end