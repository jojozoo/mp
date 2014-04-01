class AjaxController < ApplicationController
	before_filter :ajax_login
    # /ajax/laud/user/1
    # 应该包含 follow unfollow
    # tuilaud, tuilike, tuistore, tuirecom
    def tui
        @obj = params[:source].classify.constantize.find(params[:id])
        @obj.send('tui' + params[:push].pluralize).create(user_id: current_user.id)
        @count = @obj.send(params[:push].pluralize + '_count')
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
        if image = current_user.images.find_by_id(params[:id])
            image.update_attributes(del: true)
        end
        render text: 'success'
    end

    private

    def ajax_login
        # 一个patial 弹出登录框
        render js: "alert('请先登录')" and return unless sign_in?
    end
	
end