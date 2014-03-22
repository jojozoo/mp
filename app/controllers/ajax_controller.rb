class AjaxController < ApplicationController
	before_filter :ajax_login
    # /ajax/laud/user/1
    # 应该包含 follow unfollow
    # follower, tuilaud, tuilike, tuistore, tuirecom
    # follow
    def tui
        @obj = params[:source].classify.constantize.find(params[:id])
        @obj.send(params[:push].pluralize).create(user_id: current_user.id)
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