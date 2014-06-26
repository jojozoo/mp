class Admin::MpSetsController < Admin::ApplicationController
  # GET /mpsets
  # GET /mpsets.json
  def index
    @mpsets = MpSet.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /mpsets/1
  # GET /mpsets/1.json
  def show
    @mpset = MpSet.find(params[:id])
  end

  # GET /mpsets/new
  # GET /mpsets/new.json
  def new
    @mpset = MpSet.new
  end

  # GET /mpsets/1/edit
  def edit
    @mpset = MpSet.find(params[:id])
  end

  # POST /mpsets
  # POST /mpsets.json
  def create
    @mpset = MpSet.new(params[:mp_set])

    if @mpset.save
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /mpsets/1
  # PUT /mpsets/1.json
  def update
    @mpset = MpSet.find(params[:id])

    if @mpset.update_attributes(params[:mp_set])
      redirect_to action: :show, id: @mpset
    else
      render action: "edit"
    end
  end

  # DELETE /mpsets/1
  # DELETE /mpsets/1.json
  def destroy
    @mpset = MpSet.find(params[:id])
    @mpset.update_attributes(del: true)
    redirect_to admin_mpsets_path
  end
end