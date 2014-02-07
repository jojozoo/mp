class Admin::ApplicationController < ApplicationController
	layout 'admin'
    before_filter :is_admin
    
    def is_admin
        sign_in? and current_user.admin
    end
end