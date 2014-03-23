class Admin::CommentsController < Admin::ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(:page => params[:page], per_page: 20).order('id desc')
  end
  
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to action: :index
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