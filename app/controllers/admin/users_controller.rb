class Admin::UsersController < Admin::ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to action: :show, id: @user
    else
      render action: "edit"
    end
  end

  def spg
    user = User.find(params[:id])
    user.update_attribute(:photographer, !user.photographer)
    redirect_to :back
  end
  
  def sad
    user = User.find(params[:id])
    user.update_attribute(:admin, !user.admin)
    redirect_to :back
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.update_attributes(del: true)
    redirect_to admin_users_path
  end
end