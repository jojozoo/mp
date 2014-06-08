class ValidationsController < ApplicationController
    # 是否存在帐号
    def uniqueness
      username = params[:user][:username]
      exists = User.exists?(["username = ? or email = ? or mobile = ?", username, username, username])
      render text: 'success', status: exists ? 200 : 404
    end

    # 密码是否正确
    def is_valid_password

    end

    # 是否已登录
    def is_sign_in
      if user = current_user
        render text: 'true'
      else
        render text: 'false'
      end
    end

    def sign_in
      @user = User.where(["username = ? or email = ? or mobile = ?", params[:username], params[:username], params[:username]]).first
      tip = '1'
      tip = '2' if @user.blank?
      tip = '3' if @user and !@user.valid_password?(params[:password])
      render text: tip, status: 200
    end
end