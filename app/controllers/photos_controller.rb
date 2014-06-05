class PhotosController < ApplicationController
    before_filter :must_login, only: [:new, :upload, :uploadnew, :uploadie, :create]
    def index
        # 如果含有request_id就不显示活动名称 如果含有user_id 把喜欢和收藏换成删除编辑按钮
    end
    # loading 把load_data挪到这里来
    def waterfall
        @photos = load_data
        render 'waterfall', layout: false
    end

    def star
        @users = User.order("rand()").limit(10)
        # @tuis = Push.star.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @photo = Photo.find_by_id_and_state(params[:id], true)
        @photo.visits.create(user_id: current_user.try(:id))
    end

    # 图片访问权限控制
    def browse
        image = Photo.find_by_id(params[:id])
        if sign_in? and (current_user.id.eql?(image.user_id) or current_user.admin)
            send_file image.picture.path(:original), disposition: 'inline'
        else
            render text: request.path + 'not found', status: 404 and return
        end
    end
    
    def new
        # TODO 应该加上event_id 或者 album_id 索引条件
        @photos = current_user.photos.where(state: false, del: false)
        unless @event  = Event.ongoing.find_by_id(params[:eid])
           @events = Event.ongoing.where(del: false).select('id, name')
        end
    end

    def uploadnew
    end

    def uploadie
    end

    def create
        event = Event.find(params[:image_event_id])

        # TODO 判断照片数量是否至少一张
        album   = current_user.albums.find_or_create_by_name(event.name)
        album.update_attributes logo: File.open(Photo.find(params[:cover_id]).picture.path) if params[:cover_id].present?

        photos = current_user.photos.where(["id in (?)", params[:desc].keys])
        groupid = photos.last.id rescue nil
        photos.each do |image|
            desc = params[:desc][image.id.to_s]
            image.update_attributes(
                album_id: album.id, 
                event_id: event.id, 
                groupid: groupid,
                state: true, 
                desc: desc)
        end

        image_count = Photo.where(event_id: event.id).count
        membe_count = Photo.uniq.where(event_id: event.id).pluck(:user_id).length
        event.update_attributes(photos_count: image_count, members_count: membe_count)
        redirect_to event_path(event.id, order: 'myse')
    end

    def upload
        @photo = current_user.photos.create(picture: params[:filedata], name: params[:filename])
        data = {
            id: @photo.id, 
            exif: JSON.parse(@photo.exif),
            large: @photo.picture(:ielarge), 
            thumb: @photo.picture(:iethumb)
        }
        render json: data.to_json
    end

    def destroy

    end

    private

    def load_data
        con, order = {
            'news'   => [{}, 'id desc'],
            'likes'  => [{}, 'liks_count desc'],
            'push'   => [{recommend: true}, 'recommend_at desc'],
            'hot'    => [{}, 'coms_count desc'],
            'choice' => [{choice: true}, 'choice_at desc'],
            'random' => [{}, 'randomhex desc'] # TODO 缺少算法
        }[params[:order]]
        Photo.where(state: true).where(con).paginate(:page => params[:page], per_page: 12).order(order)
    end
end