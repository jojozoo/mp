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
        # 如果没有类型就跳转到上传页,
        redirect_to action: 'new' if params[:type].blank?
        @image = Image.create(picture: params[:Filedata], name: params[:Filename], user_id: User.first.id)

        data = if params[:type].eql?('avatar')
             {
                width: @image.picture.width,
                height: @image.picture.height,
                size: @image.picture.size,
                url: @image.picture.url(:original)
            }
        else
            {
                time: @image.created_at.to_s(:db),
                url: @image.picture.url(:cover)
            }
        end
        render json: data.to_json
    end
end