class UsersController < ApplicationController

    def profile
        
    end

    def update

    end

    def avatar
        current_user.update_attributes!(avatar: params[:Filedata])
        width, height = Paperclip::Geometry.from_file(current_user.avatar.path).to_s.split('x').map(&:to_i) rescue [300, 300]
        data = {
            width: width,
            height: height,
            size: current_user.avatar.size,
            url: current_user.avatar.url
        }
        
        render json: data.to_json
    end

    def cut
        # @image = @current_user.images.find(params[:id])
        # user.avatar = File.open(paperclip.run('-crop 200x100+0+0'))
        # 再确定是头像照片
        # 之后再裁剪
        current_user.x = params[:cut][:x]
        current_user.y = params[:cut][:y]
        current_user.w = params[:cut][:w]
        current_user.h = params[:cut][:h]
        current_user.save!
        redirect_to :back
    end
    
end