class CommentsController < ApplicationController
    
    def create
        obj = case params[:obj]
        when 'image'
            Image.find(params[:id])
        when 'topic'
            Topic.find(params[:id])
        when 'work'
            Work.find(params[:id])
        end
        obj.comments.create(params[:comment].merge(user_id: current_user.id))
        obj.update_attributes(last_user_id: current_user.id, last_updated_at: Time.now) if params[:obj].eql?('topic')
        redirect_to :back
    end
end