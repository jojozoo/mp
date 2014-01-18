class ImagesController < ApplicationController
    
    def new
        @event = Event.find_by_id(params[:eid])
    end

    def show

    end

    def cut
        @image = @current_user.images.find(params[:id])
        # 再确定是头像照片
        # 之后再裁剪

    end

    def create
        @image = Image.create(picture: params[:Filedata], name: params[:Filename], user_id: User.first.id)
        
        json = {
            width: @image.picture.width, 
            height: @image.picture.height, 
            size: @image.picture.size,
            original: @image.picture.url(:cover)
        }
        render json: json.to_json
    end
end