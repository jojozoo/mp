class Admin::CommentsController < Admin::ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      redirect_to action: :index, notice: 'Comment was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to action: :show, id: @comment, notice: 'ok'
    else
      render action: "edit"
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.update_attributes(del: true)
    redirect_to admin_comments_path
  end
end