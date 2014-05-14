class TopicsController < ApplicationController

    def index
        if params[:tag].present? and @tag = Tag.find_by_name(params[:tag])
            @topics = Topic.where(tag_id: @tag.id).paginate(:page => params[:page], per_page: 20).order('id desc')
            render 'index_tag' and return
        else
            @topics = Topic.order('comments_count desc, id desc').limit(20)
        end
    end

    def explore
       @topics = Topic.paginate(:page => params[:page], per_page: 20).order('id desc') 
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def new
        unless sign_in?
            redirect_to action: :index
            flash[:notice] = '请先登录'
            return
        else
            @owner = Event.find_by_name(params[:tag]) if params[:tag].present?
            @topic = Topic.new
        end
    end

    def create
        params[:topic][:tag_id] = params[:topic_tag_id]
        if @topic = Topic.create!(params[:topic].slice(:title, :content, :tag_id).merge(user_id: current_user.id))
            redirect_to action: :show, id: @topic.id
        else
            render action: :new
        end
    end

    def edit
        unless sign_in?
            redirect_to action: :index
            flash[:notice] = '请先登录'
            return
        else
            @topic = current_user.topics.find(params[:id])
            @owner = @topic.owner
        end
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