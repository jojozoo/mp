class Admin::TagsController < Admin::ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.paginate(:page => params[:page], per_page: 20).order('sum desc')
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
      flash[:notice] = "Tag was successfully created."
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
      flash[:notice] = "更新成功"
      redirect_to action: :edit, id: @tag.id
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