class Oauth::QqController < Oauth::ApplicationController
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
        
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        user = token.get("/oauth2.0/me")
        render text: user.body
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/oauth2.0/authorize', token_url: '/oauth2.0/token')
    end
end