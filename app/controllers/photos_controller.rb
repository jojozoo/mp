class PhotosController < ApplicationController
    before_filter :must_login, only: [:browse, :new, :upload, :uploadnew, :uploadie, :create]
    def index
        params[:q] ||= {n: 'news', o: 'id desc', s: 'cols', w: {tag_id: []}}
        params[:q][:s] = 'cols'
        # 如果含有request_id就不显示活动名称 如果含有user_id 把喜欢和收藏换成删除编辑按钮
    end
    # loading 把load_data挪到这里来
    def waterfall
        params[:q] = {
            o: params[:q][:o] || 'id desc',
            n: params[:q][:n] || 'news',
            s: params[:q][:s] || 'cols',
            w: params[:q][:w] || {},
        }
        hash = {
            'news'  => ['id desc', {}],
            'choi'  => ['choice_at desc', {}],
            'liks'  => ['liks_count desc', {}],
            'coms'  => ['coms_count desc', {}],
            'recs'  => ['recommend_at desc', { recommend: true }],
            'choi'  => ['choice_at desc', { choice: true}],
            'radm'  => ['randomhex desc', {}],
            'vist'  => ['visit_count desc', {}],
            'myse'  => ['visit_count desc', {}]
        }
        o = hash[params[:q][:n]][0] rescue 'id desc'
        params[:q][:w].slice(*[:request_id, :user_id, :tag_id])
        request_id = params[:q][:w][:request_id]
        user_id       = params[:q][:w][:user_id]
        tag_id         = params[:q][:w][:tag_id]
        w = hash[params[:q][:n]][1] rescue {}
        w.merge!(event_id: request_id) if request_id.present?
        w.merge!(user_id: user_id) if user_id.present?
        w.merge!(user_id: current_user.try(:id)) if params[:q][:n].eql?('myse')
        # w.merge!(tag_id: tag_id) if tag_id.present?
        @photos = Photo.where(w.merge(parent_id: nil)).paginate(:page => params[:page], per_page: 16).order(o)
        render 'waterfall', layout: false
    end

    def show
        # 有几种组的方式 默认以人为单位 其次是某天 其次是推荐 其次是精选 其次是某一集合
        @photo  = Photo.find(params[:id])
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
        @event  = Event.ongoing.find_by_id(params[:request_id]) if params[:request_id].present?
        @album  = current_user.albums.find_by_id(params[:album_id]) if params[:album_id].present?
    end

    def edit
        photo = Photo.find(params[:id])
        
        if photo.isgroup
            pid = photo.parent_id.blank? ? photo.id : photo.parent_id
            @photos = Photo.where(parent_id: pid, isgroup: true)
            @group = Photo.find(pid)
        else
            @photos = [photo]
        end
        @photo = photo.parent_id.blank? ? @photos.first : photo
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
    end

    def destroy

    end
end