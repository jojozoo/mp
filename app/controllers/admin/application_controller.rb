class Admin::ApplicationController < ApplicationController
	layout 'admin1'
    before_filter :is_admin
    
    def is_admin
        redirect_to '/404' unless sign_in? and current_user.admin
    end
end