class Admin::GroupsController < Admin::ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    if @group.save
      redirect_to action: :index, notice: 'Group was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      redirect_to action: :show, id: @group, notice: 'ok'
    else
      render action: "edit"
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.update_attributes(del: true)
    redirect_to admin_groups_path
  end
end