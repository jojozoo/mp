class AjaxController < ApplicationController
	before_filter :ajax_login
    def tui
        @obj = params[:source].classify.constantize.find(params[:id])
        @obj.send('tui' + params[:push].pluralize).create(user_id: current_user.id)
        @count = @obj.send(params[:push].pluralize + '_count')
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
        @glass = params[:isglass].eql?('true') ? '' : 'btn btn-default btn-xs'
        if user = User.find_by_id(params[:id])
            user.follower_ships.create(follower_id: current_user.id) rescue nil
        end
    end

    # 取消关注
    def ufl
        @glass = params[:isglass].eql?('true') ? '' : 'btn btn-default btn-xs'
        if user = User.find_by_id(params[:id])
            fol = user.follower_ships.find_by_follower_id(current_user.id)
            fol.destroy if fol
        end
    end

    # comment
    def com
        obj = case params[:source]
        when 'image'
            Image.find(params[:id])
        when 'topic'
            Topic.find(params[:id])
        when 'work'
            Work.find(params[:id])
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
        render js: "alert('请先登录')" and return unless sign_in?
    end
	
end