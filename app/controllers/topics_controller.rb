class TopicsController < ApplicationController
    before_filter :must_login, only: [:new, :create, :edit, :update, :destroy]

    def index
        @topics = Topic.order('coms_count desc, id desc').limit(20)
    end

    def cate
        @cate = Tag.find(params[:cate_id])
        @topics = Topic.where(cate_id: @cate.id).paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def explore
       @topics = Topic.paginate(:page => params[:page], per_page: 20).order('id desc') 
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def new
        if params[:cate].present?
            @owner = Event.find_by_name(params[:cate])
            @cate  = Tag.find_by_name(params[:cate])
        end
        @topic = Topic.new
    end

    def create
        params[:topic][:owner_id] = params[:topic_owner_id]
        if @topic = Topic.create!(params[:topic].slice(:title, :content, :cate_id, :original).merge(user_id: current_user.id))
            redirect_to action: :show, id: @topic.id
        else
            render action: :new
        end
    end

    def edit
        @topic = current_user.topics.find(params[:id])
        @owner = @topic.owner
        @cate  = @topic.cate
    end

    def update
        @topic = current_user.topics.find(params[:id])
        if @topic.update_attributes!(params[:topic].slice(:title, :content, :cate_id, :original))
            redirect_to action: :show, id: @topic.id
        else
            render action: :edit
        end
    end

end