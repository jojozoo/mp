class PhotosController < ApplicationController
    before_filter :must_login, only: [:browse, :new, :upload, :uploadnew, :uploadie, :create, :edit, :update, :simple, :complex]
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
        @photo  = Photo.find(params[:id])
        @photo.visits.create(user_id: current_user.try(:id))
        if @photo.isgroup and @photo.parent_id.blank?
            @photos = @photo.childrens
            @comments = Comment.where(obj_type: 'Photo', obj_id: @photos.map(&:id) + [@photo.id]).paginate(:page => params[:page], per_page: 20).order('id desc')
            render 'group_show'
        else
            @photos = [@photo]
            @comments = @photo.comments.paginate(:page => params[:page], per_page: 20).order('id desc')
        end
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
        
        if params[:go_id].present?
            @group = current_user.photos.find_by_id(params[:go_id])
            @event = @group.event
            @album = @group.album
        end
        @event  ||= Event.ongoing.find_by_id(params[:request_id]) if params[:request_id].present?
        @album  ||= current_user.albums.find_by_id(params[:album_id]) if params[:album_id].present?
    end

    def simple
        render layout: 'complex'
    end

    def complex
        if params[:go_id].present?
            @group = current_user.photos.find_by_id(params[:go_id])
            @event = @group.event
            @album = @group.album
        end
        @event  ||= Event.ongoing.find_by_id(params[:request_id]) if params[:request_id].present?
        @album  ||= current_user.albums.find_by_id(params[:album_id]) if params[:album_id].present?
        render layout: 'complex'
    end

    def edit
        photo = current_user.photos.find(params[:id])
        if photo.isgroup
            pid = photo.parent_id.blank? ? photo.id : photo.parent_id
            @photos = Photo.where(parent_id: pid, isgroup: true)
            @group = Photo.find(pid)
        else
            @photos = [photo]
        end
        photo = Photo.find_by_id(params[:up_id]) || photo if params[:up_id].present?
        @photo = photo.parent_id.blank? ? @photos.first : photo
    end

    def update
        ps = params[:arr].values.map do|photo| 
            r = photo.slice(*['id', 'title', 'desc', 'event_id', 'album_id', 'warrant', 'exif', 'crop', 'tags', 'tpid'])
            p = if current_user.admin
                Photo.find_by_id(r['id'])
            else
                current_user.photos.find_by_id(r['id'])
            end
            next unless p
            p.update_attributes(r)
        end
        render text: 'success'
    end

    def uploadnew
    end

    def uploadswf
        
    end

    def create
        isgroup = params[:group] and params[:group][:title] and params[:group][:desc]
        parent = if params[:go_id].present? and tp = current_user.photos.find_by_id(params[:go_id])
            if tp.isgroup
                if tp.parent_id.blank?
                    tp
                else
                    Photo.find_by_id(tp.parent_id)
                end
            else
                tpar = Photo.create(params[:group].merge(user_id: current_user.id, isgroup: true))
                tp.update_attributes(isgroup: true, parent_id: tpar.id)
                tpar
            end
        end
        parent ||= Photo.create(params[:group].merge(user_id: current_user.id, isgroup: true)) if isgroup
        
        items = params['items'].values.map{|r| r.slice(*['title', 'desc', 'event_id', 'album_id', 'warrant', 'exif', 'crop', 'tags', 'tpid'])}
        res = Photo.create_items(items, current_user.id, parent)
        render text: photo_path(res.id)
    end

    def destroy

    end
end