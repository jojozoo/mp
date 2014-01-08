class GalleriesController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], per_page: 3).order(params[:order])
  end

end