class Admin::BgsController < Admin::ApplicationController
  # GET /bgs
  # GET /bgs.json
  def index
    @bgs = Sbg.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /bgs/1
  # GET /bgs/1.json
  def show
    @bg = Sbg.find(params[:id])
  end

  # GET /bgs/new
  # GET /bgs/new.json
  def new
    @bg = Sbg.new
  end

  # GET /bgs/1/edit
  def edit
    @bg = Sbg.find(params[:id])
  end

  # POST /bgs
  # POST /bgs.json
  def create
    @bg = Sbg.new(params[:sbg])

    if @bg.save
      redirect_to action: :index, notice: 'Sbg was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /bgs/1
  # PUT /bgs/1.json
  def update
    @bg = Sbg.find(params[:id])

    if @bg.update_attributes(params[:sbg])
      redirect_to action: :show, id: @bg, notice: 'ok'
    else
      render action: "edit"
    end
  end

  # DELETE /bgs/1
  # DELETE /bgs/1.json
  def destroy
    @bg = Sbg.find(params[:id])
    @bg.update_attributes(del: true)
    redirect_to admin_bgs_path
  end
end