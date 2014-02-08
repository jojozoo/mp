require 'oauth2'
class Oauth::ApplicationController < ApplicationController

    before_filter :oauth

    def oauth
        YAML.load_file('config/oauth.yml')[controller_name]
    end

end