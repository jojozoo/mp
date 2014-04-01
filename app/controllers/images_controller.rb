class ImagesController < ApplicationController
    def index
        params[:o] = params[:o] || 'id desc'
        order = params[:o]
        @images = if ['tui', 'eve'].member?(params[:o])
            channel = params[:o].eql?('tui') ? '编辑推荐' : '每日精选'
            order = 'ps.id desc'
            Image.joins(" left join (select * from pushes where source_type = 'Image' and channel = '#{channel}') ps on ps.source_id = images.id")
        else
            Image.where(state: true)
        end.paginate(:page => params[:page], per_page: 12).order(order)
    end

    def waterfall
        @images = Image.where(state: true).paginate(:page => params[:page], per_page: 12).order('id desc')
        render '_waterfall', layout: false
    end

    def star
        @pushes = Push.where(channel: '漫拍之星').paginate(:page => params[:page], per_page: 20).order('id desc')
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