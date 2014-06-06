class ValidationsController < ApplicationController
	# 是否存在帐号
    def is_account
    	exists = User.exists?(["username = ? or email = ? or mobile = ?", params[:username], params[:username], params[:username]])
    	render text: exists, status: 200
    end

    # 密码是否正确
    def is_valid_password
        
    end

    # 是否已登录
    def is_sign_in
    	if user = current_user
        	render json: { data: { id: user.id, name: user.username, avatar: user.avatar(:small) } }
    	else
    		render json: { error: 1 }
    	end
    end
end