class AjaxController < ApplicationController
    before_filter :ajax_login
    
    # 推荐
    def rec
        res = Tui.cho_or_rec('recommend', params[:id], current_user)
        render json: res.to_json
    end

    def cho
        res = Tui.cho_or_rec('choice', params[:id], current_user)
        render json: res.to_json
    end

    # 关注 
    # 取消关注
    def fol

    end

    def like

    end

    def store

    end

    def selfrecommend

    end

    def choice

    end


    # def tui
    #     @obj = params[:source].classify.constantize.find(params[:id])
    #     @obj.send('tui' + params[:push].pluralize).create(user_id: current_user.id)
    #     @count = @obj.send(params[:push].pluralize + '_count')
    # end

    def tag
        render json: {availableTags: Tag.limit(10).map(&:name), assignedTags: []}.to_json
    end

    def editer
        @obj = Image.find(params[:id])
        attrs = {
          obj_id: @obj.id,
          obj_type: 'Image',
          channel: '编辑推荐',
          source_id: @obj.id,
          source_type: 'Image',
          user_id: current_user.id
        }
        push = Push.where(attrs).first
        if params[:cancel] == 'true'
            push.destroy if push
        else
            unless push
                stime = Date.today.to_s + ' 00:00:00'
                etime = Date.today.to_s + ' 23:59:59'
                tuiids = Push.where(obj_type: 'Image', user_id: current_user.id, channel: '编辑推荐').where(["updated_at between ? and ?", stime, etime]).map(&:obj_id)
                @member = Member.find_by_event_id_and_user_id(params[:eid], current_user.id)
                if tuiids.length < @member.sum
                    push = Push.create!(attrs.merge(mark: '暂无备注'))
                else
                    @alert = true
                end    
            end
        end
    end

    # 关注
    def fol
        if user = User.find_by_id(params[:id])
            user.folships.create(fol_id: current_user.id)
        end
    end

    # 取消关注
    def ufl
        if user = User.find_by_id(params[:id])
            fol = user.folships.find_by_fol_id(current_user.id)
            fol.destroy if fol
        end
    end

    # comment
    def com
        obj = case params[:source]
        when 'photo'
            Photo.find(params[:id])
        when 'topic'
            Topic.find(params[:id])
        when 'work'
            Work.find(params[:id])
        when 'collection'
            Collection.find(params[:id])
        end
        @comment = obj.comments.create!(params[:comment].merge(user_id: current_user.id))
        obj.update_attributes(last_user_id: current_user.id, last_updated_at: Time.now) if params[:obj].eql?('topic')
        redirect_to :back
    end

    # ajax_del_path
    def del
        if photo = current_user.photos.find_by_id(params[:id])
            photo.update_attributes(del: true)
        end
        render text: 'success'
    end

    private

    def ajax_login
        # 一个patial 弹出登录框
        unless sign_in?
            if request.xhr?
                render json: {text: "请先登录", type: 'error'}.to_json
            else
                flash[:notice] = "请先登录"
            end and return
        end
    end
	
end