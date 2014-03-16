class AjaxController < ApplicationController
	before_filter :must_login
    # /ajax/laud/user/1
    # 应该包含 follow unfollow
    def tui
        
    end

    # comment
    def com

    end

    # ajax_del_path
    def del
        if image = current_user.images.find_by_id(params[:id])
            image.update_attributes(del: true)
        end
        render text: 'ok'
    end
	
end