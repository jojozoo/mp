class TopicsController < ApplicationController

    def index
        if params[:tag].present? and @tag = Tag.find_by_name(params[:tag])
            @topics = Topic.where(tag_id: @tag.id).paginate(:page => params[:page], per_page: 20).order('id desc')
            render 'index_tag' and return
        else
            @topics = Topic.paginate(:page => params[:page], per_page: 20).order('id desc')
        end
    end

    def explore
       @topics = Topic.paginate(:page => params[:page], per_page: 20).order('id desc') 
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def new
        @topic = Topic.new
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
        @tag = @topic.tag
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