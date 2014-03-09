class Admin::TagsController < Admin::ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    if @tag.save
      redirect_to action: :index, notice: 'Tag was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
      redirect_to action: :show, id: @tag, notice: 'ok'
    else
      render action: "edit"
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.update_attributes(del: true)
    redirect_to admin_tags_path
  end
end