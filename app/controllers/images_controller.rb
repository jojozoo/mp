class ImagesController < ApplicationController
    def index
        @images = load_data
    end

    def waterfall
        @images = load_data
        render '_waterfall', layout: false
    end

    def load_data
        order = {
            'news'  => 'id desc',
            'likes' => 'likes_count desc',
            'push'  => 'ps.id desc',
            'hot'   => 'comments_count desc',
            'exp'   => 'ps.id desc',
            'random' => 'randomhex asc'
        }[params[:order]]
        unless order
            params[:order] = 'news'
            order = 'id desc'
        end
        # TODO 不一样的选项render不一样的partial
        if ['push', 'exp'].member?(params[:order])
            channel = params[:order].eql?('push') ? '编辑推荐' : '每日一图'
            # Image.joins(" left join (select * from pushes where source_type = 'Image' and channel = '#{channel}') ps on ps.source_id = images.id")
            Image.joins(" inner join pushes ps on ps.obj_id = images.id").where("ps.channel = '#{channel}'")
        else
            Image.where(state: true)
        end.paginate(:page => params[:page], per_page: 12).order(order)
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
        # TODO 应该加上event_id 或者 album_id 索引条件
        @images = current_user.images.where(state: false, del: false)
        unless @event  = Event.ongoing.find_by_id(params[:eid])
           @events = Event.ongoing.where(del: false).select('id, name')
        end
    end

    def create
        event = Event.find(params[:image_event_id])
        params[:cover_id] = params[:desc].keys[0] if params[:cover_id].blank?

        # TODO 判断照片数量是否至少一张
        album   = current_user.albums.find_or_create_by_name(event.name)
        album.update_attributes logo: File.open(Image.find(params[:cover_id]).picture.path)
        current_user.images.where(["id in (?)", params[:desc].keys]).each do |image|
            desc = params[:desc][image.id.to_s]
            image.update_attributes(
                album_id: album.id, 
                event_id: event.id, 
                state: true, 
                desc: desc)
        end

        image_count = Image.where(event_id: event.id).count
        membe_count = Work.uniq.where(event_id: event.id).pluck(:user_id).length
        event.update_attributes(images_count: image_count, members_count: membe_count)
        redirect_to event_path(event.id, order: 'myse')
    end

    def upload
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