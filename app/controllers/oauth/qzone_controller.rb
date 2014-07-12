class Oauth::QzoneController < Oauth::ApplicationController
    def index
        redirect_to client.auth_code.authorize_url(:redirect_uri => oauth['callback'])
    end

    def callback
        redirect_to '/sign_in' and return if params[:code].blank?
        
        token = client.auth_code.get_token(params[:code], :redirect_uri => oauth['callback'], parse: :query)
        token.options[:mode] = :query
        token.options[:param_name] = :access_token
        open = token.get("/oauth2.0/me")
        openid = open.body.match(/"openid":"(?<openid>\w+)"/)[:openid]
        qzone = token.get('/user/get_user_info', params: {:openid => openid, :oauth_consumer_key => oauth['key']}, parse: :json).parsed
        
        other = {
            uid:      openid,
            name:     qzone['nickname'],
            gender:   qzone['gender'],
            avatar:   qzone['figureurl_2'],
            other:    qzone
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
    # rescue => e
    #     logger.info("#{controller_name} account login error #{e.to_s}")
    #     redirect_to '/sign_in'
    end

    def client
        OAuth2::Client.new(oauth['key'], oauth['secret'], :site => oauth['url'], authorize_url: '/oauth2.0/authorize', token_url: '/oauth2.0/token')
    end
end