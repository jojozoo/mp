class Admin::TopicsController < Admin::ApplicationController
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @event = Event.find_by_id(params[:eid])
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])

    if @topic.save!
      flash[:notice] = 'Topic was successfully created.'
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      flash[:notice] = "更新成功"
      redirect_to action: :show, id: @topic
    else
      render action: "edit"
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.update_attributes(del: true)
    redirect_to admin_topics_path
  end
end