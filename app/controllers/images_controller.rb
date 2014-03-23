class ImagesController < ApplicationController
    def index
        params[:o] = params[:o] || 'all'
        @images = Image.where(state: true).paginate(:page => params[:page], per_page: 12).order('id desc')
        case params[:o]
        when ''

        when ''

        end
    end

    def waterfall
        @images = Image.where(state: true).paginate(:page => params[:page], per_page: 12).order('id desc')
        render '_waterfall', layout: false
    end

    def star
        @users = User.limit(10)
    end

    def show
        @image = Image.find_by_id_and_state(params[:id], true)
    end

    # 图片访问权限控制
    def browse
        send_path = "public/system/#{params[:class]}/#{params[:id]}/#{params[:style]}/#{params[:random]}.#{params[:format]}"
        if params[:class].eql?('images') and image = Image.find_by_id(params[:id])
            send_path = image.picture.path(params[:style])
            if params[:style].eql?('original')
                if sign_in? and (current_user.id.eql?(image.user_id) or current_user.admin)
                    # 反着写
                else
                    render text: request.path + 'not found', status: 404 and return
                end
            end
        end
        send_file send_path, disposition: 'inline'
    end
    
    def new
        redirect_to images_path, notice: '请先登录' and return unless sign_in?
    end

    def create
        redirect_to '/' and return unless sign_in?

        @image = current_user.images.create(picture: params[:Filedata], name: params[:Filename])
        data = {
                time: @image.created_at.to_s(:db),
                url: @image.picture(:cover),
                id: @image.id
            }
        render json: data.to_json
    end

    def destroy
    end
end