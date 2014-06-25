class AjaxController < ApplicationController
    before_filter :ajax_login
    
    # 推荐
    def rec
        res = if current_user.admin
            Tui.cho_or_rec('recommend', @photo, current_user, true)
        # elsif current_user.editor?   # 如果不针对活动的推荐，再加判断
        elsif editor = Editor.where(event_id: @photo.event_id, editor_id: current_user.id).first
            day = Date.today.to_s(:number)
            sum = Tui.where(editor_id: current_user.id, day: day, event_id: @photo.event_id).count
            if editor.sum > sum
                Tui.cho_or_rec('recommend', @photo, current_user, true)
            else
                {text: "您对此活动的推荐已到上限", type: 'error'}
            end
        else
        {text: "您没有权限", type: 'error'}
        end
        render json: res.to_json
    end

    def cho
        res = unless current_user.admin
            {text: "您没有权限", type: 'error'}
        else
            Tui.cho_or_rec('choice', @photo, current_user, true)
        end
        render json: res.to_json
    end

    # 关注 
    # 取消关注
    def fol
        res = if user = User.find_by_id(params[:id])
            if fol = current_user.folships.find_by_user_id(user.id)
                fol.destroy
                {text: "取消成功", type: 'success'}
            else
                current_user.folships.create(user_id: user.id)
                {text: "关注成功", type: 'success'}
            end
        else
           {text: "没有此用户", type: 'error'}
        end
        render json: res.to_json 
    end

    def lik
        res = Tui.cho_or_rec('liks', @photo, current_user)
        render json: res.to_json
    end

    def sto
        res = Tui.cho_or_rec('stos', @photo, current_user)
        render json: res.to_json
    end

    def selfrecommend

    end


    # def tui
    #     @obj = params[:source].classify.constantize.find(params[:id])
    #     @obj.send('tui' + params[:push].pluralize).create(user_id: current_user.id)
    #     @count = @obj.send(params[:push].pluralize + '_count')
    # end

    def tag
        render json: {availableTags: Tag.limit(10).map(&:name), assignedTags: []}.to_json
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
            render json: {text: "删除成功", type: 'success'}.to_json
        else
            render json: {text: "资源错误", type: 'error'}.to_json
        end
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
        unless @photo = Photo.find_by_id(params[:id])
            render json: {text: "资源错误", type: 'error'}.to_json
        end and return
    end
	
end