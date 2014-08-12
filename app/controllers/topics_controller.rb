class TopicsController < ApplicationController
    before_filter :must_login, only: [:new, :create, :edit, :update, :destroy]

    def index
        @title = "话题 - 漫拍网"
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
        @title = "#{@topic.title} - 话题 - 漫拍网"
        @topic.visits.create(user_id: current_user.try(:id))
        @comments = @topic.comments.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def new
        if params[:tid].present?
            @cate  = Tag.find_by_id(params[:tid])
        end
        @topic = Topic.new(cate_id: @cate.try(:id))
    end

    def create
        if @topic = Topic.create!(params[:topic].slice(:title, :content, :cate_id, :original).merge(user_id: current_user.id))
            if current_user.admin
                if params[:gohome].eql?('on')
                    MpSet.create(title: @topic.title, link: topic_url(@topic.id), cate: 5, cate_id: 0, user_id: current_user.id)
                end
                if params[:goinfo].eql?('on')
                    MpSet.create(title: @topic.title, link: topic_url(@topic.id), cate: 8, cate_id: 0, user_id: current_user.id)
                end
                if params[:goevent].eql?('on')
                    if ecate = Tag.find_by_id(@topic.cate_id)
                        if event = Event.find_by_name(ecate.name)
                            MpSet.create(title: @topic.title, link: topic_url(@topic.id), cate: 6, cate_id: event.id, user_id: current_user.id)
                        end
                    end
                end
            end
            redirect_to action: :show, id: @topic.id
        else
            render action: :new
        end
    end

    def edit
        @topic = current_user.topics.find(params[:id])
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