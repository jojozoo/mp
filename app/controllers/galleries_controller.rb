class GalleriesController < ApplicationController

  def index
    @objs = Image.paginate(:page => params[:page], per_page: 10).order('rand()')
    if request.xhr?
        render partial: 'row', collection: @objs, as: :image
        return
    end
  end

end