class Oauth::WeiboController < Oauth::ApplicationController
    
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        render text: token
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/oauth2/authorize', token_url: '/oauth2/access_token')
    end
end