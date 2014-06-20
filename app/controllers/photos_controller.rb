class PhotosController < ApplicationController
    before_filter :must_login, only: [:browse, :new, :upload, :uploadnew, :uploadie, :create]
    def index
        # 如果含有request_id就不显示活动名称 如果含有user_id 把喜欢和收藏换成删除编辑按钮
    end
    # loading 把load_data挪到这里来
    def waterfall
        @photos = load_data
        render 'waterfall', layout: false
    end

    def show
        # 有几种组的方式 默认以人为单位 其次是某天 其次是推荐 其次是精选 其次是某一集合
        @photo  = Photo.find_by_id(params[:id])
        @photos = case params[:sn]
        when 'group' # 组 应该有个组id
            Photo.where(parent_id: params[:sid])
        when 'choice' # 如果是精选 应该有个日期
            Photo.where(user_id: params[:sid], choice: true)
        when 'recom' # 如果是推荐 应该有个日期
            Photo.where(user_id: params[:sid], recommend: true)
        else # 个人作品
            Photo.where(user_id: params[:sid]).order("id desc")
        end.limit(10)
        @photo.visits.create(user_id: current_user.try(:id))
    end

    # 图片访问权限控制
    def browse
        photo = Photo.find_by_id(params[:id])
        if photo and (current_user.id.eql?(photo.user_id) or current_user.admin)
            send_file photo.picture.path(:original), disposition: 'inline'
        else
            render text: request.path + 'not found', status: 404
        end
    end
    
    def new
        # TODO 应该加上event_id 或者 album_id 索引条件
        @event  = Event.ongoing.find_by_id(params[:request_id])
    end

    def uploadnew
    end

    def uploadswf
        
    end

    def create
        parent = if params[:group].present? and params[:group][:title].present? and params[:group][:desc].present?
            Photo.create(params[:group].merge(user_id: current_user.id, isgroup: true))
        end
        items = params['items'].values.map{|r| r.slice(*['title', 'desc', 'event_id', 'album_id', 'warrant', 'exif', 'crop', 'tags', 'tpid'])}
        # TODO
        items.map{|r| r['exif'] = r['exif'].to_json;r['crop'] = r['crop'].to_json;r }

        Photo.create_items(items, current_user.id, parent)
        render text: 'success'

        # params[:tps].values.each do |item|
        #     event   = Event.find(item[:request_id])
        #     tp      = Tp.find(item[:tpid])
        #     title   = item[:title]
        #     desc    = item[:desc]
        #     warrant = item[:warrant]
        #     exif    = item[:exif].to_json
        #     photo = Photo.create!(
        #         picture: File.open(tp.picture.path), 
        #         event_id: event.try(:id),
        #         title: title,
        #         desc: desc,
        #         user_id: current_user.id,
        #         state: true,
        #         warrant: warrant,
        #         isgroup: parent ? true : false,
        #         parent_id: parent ? parent.id : nil,
        #         exif: exif)
        #     result.push(photo)
        #     oh      = item[:cropAttr][:oh].to_i
        #     w       = item[:crop][:w].to_i
        #     h       = item[:crop][:h].to_i
        #     x       = item[:crop][:x].to_i
        #     y       = item[:crop][:y].to_i
        #     h = oh if h > oh
        #     if w.zero? or h.zero?
        #         w = h = oh
        #         x = y = 0
        #     end
        #     # TODO xy bug
        #     # system ("convert -crop #{w}x#{h}+#{x}+#{y} #{photo.picture.path} #{photo.picture.path(:cover)}")
        #     image_count = Photo.where(event_id: event.id).count
        #     membe_count = Photo.uniq.where(event_id: event.id).pluck(:user_id).length
        #     event.update_attributes(photos_count: image_count, members_count: membe_count)
        # end
        # if parent
        #     last = result.last
        #     parent.update_attributes!(
        #         picture: File.open(last.picture.path),
        #         event_id: last.event_id,
        #         state: true,
        #         warrant: last.warrant
        #         )
        # end
        # render text: 'success'
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
        Photo.where(con.merge(parent_id: nil)).paginate(:page => params[:page], per_page: 16).order(order)
    end
end