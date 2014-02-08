class Oauth::QqmpController < Oauth::ApplicationController
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
        
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'])
        render text: user.body
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/cgi-bin/oauth2/authorize', token_url: '/cgi-bin/oauth2/token')
    end
end