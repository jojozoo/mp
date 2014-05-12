class Admin::WorksController < Admin::ApplicationController
  # GET /works
  # GET /works.json
  def index
    @works = Work.where(params[:con]).paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /works/1
  # GET /works/1.json
  def show
    @work = Work.find(params[:id])
  end

  # GET /works/new
  # GET /works/new.json
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(params[:work])

    if @work.save
      flash[:notice] = 'Topic was successfully created.'
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /works/1
  # PUT /works/1.json
  def update
    @work = Work.find(params[:id])

    if @work.update_attributes(params[:work])
      flash[:notice] = "更新成功"
      redirect_to action: :show, id: @work
    else
      render action: "edit"
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work = Work.find(params[:id])
    @work.update_attributes(del: true)
    redirect_to admin_works_path
  end
end