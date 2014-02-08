class Oauth::DoubanController < Oauth::ApplicationController
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        token.client.site = 'https://api.douban.com'
        user = token.get("/v2/user/~me")
        render text: user.body
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/service/auth2/auth', token_url: '/service/auth2/token')
    end

end