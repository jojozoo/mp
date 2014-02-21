class GroupsController < ApplicationController
	def index
        @topics = if params[:t].eql?('publish')
            current_user.topics.paginate(:page => params[:page], per_page: 20).order('id desc')
        elsif params[:t].eql?('explore')
            Topic.paginate(:page => params[:page], per_page: 20).order('updated_at desc')
        else
            Topic.paginate(:page => params[:page], per_page: 20).order('id desc')
        end
	end

    def new
        @group = Group.new
    end

    def create
        params[:group][:desc] = params[:group][:desc].gsub(/<\/?.*?>/, "").gsub(/\n+/,"<br>") if params[:group][:desc].present?
        @group = current_user.groups.create(params[:group])
        redirect_to @group
    end

    def show
        @group = Group.find(params[:id])
        @topics = @group.topics.paginate(:page => params[:page], per_page: 20).order('id desc')
        @speak  = @group.speak?(current_user.id) if current_user
    end

    def edit
       @group = current_user.groups.find(params[:id])
    end

    def update
        params[:group][:desc] = params[:group][:desc].gsub(/<\/?.*?>/, "").gsub(/\n+/,"<br>") if params[:group][:desc].present?
        
        if @group = current_user.groups.find(params[:id])
            @group.update_attributes!(params[:group])
        end
        redirect_to @group
    end

    # 我的圈子创建不应该超过5个
    def me
        @groups = current_user.groups
    end

    # TODO 发现圈子 标签符合的, 话题多的, 喜欢多的, 推荐多的
    def explore

    end
end