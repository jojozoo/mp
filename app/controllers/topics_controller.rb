class TopicsController < ApplicationController

    def index

    end

    def show
        @topic = Topic.find(params[:id])
    end

    def new
        @group = current_user.speak_groups.find(params[:group_id])
        @topic = @group.topics.new
    end

    def create
        @group = current_user.speak_groups.find(params[:group_id])
        if @topic = @group.topics.create!(params[:topic].slice(:title, :content).merge(user_id: current_user.id))
            redirect_to action: :show, id: @topic.id
        else
            render action: :new
        end
    end

    def edit
        @topic = current_user.topics.find(params[:id])
        @group = @topic.group
    end

    def update
        @topic = current_user.topics.find(params[:id])
        # 防止串改 group_id
        if @topic.update_attributes!(params[:topic].slice(:title, :content))
            redirect_to action: :show, id: @topic.id
        else
            render action: :edit
        end
    end

end