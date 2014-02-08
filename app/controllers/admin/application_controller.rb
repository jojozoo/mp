class Admin::ApplicationController < ApplicationController
	layout 'admin'
    before_filter :is_admin
    
    def is_admin
        redirect_to root_path unless sign_in? and current_user.admin
    end
end