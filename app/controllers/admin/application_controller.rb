class Admin::ApplicationController < ApplicationController
	layout 'admin'
    before_filter :must_login, :is_admin
    
    def is_admin
      redirect_to '/404' and return unless current_user.admin
    end
end