class Admin::ApplicationController < ApplicationController
	layout 'admin1'
    before_filter :is_admin
    
    def is_admin
        if !sign_in? and !current_user.admin
            redirect_to '/404' and return
        end
    end
end