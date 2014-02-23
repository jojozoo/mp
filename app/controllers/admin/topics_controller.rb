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

    if @topic.save
      redirect_to action: :index, notice: 'Topic was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to action: :show, id: @topic, notice: 'ok'
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