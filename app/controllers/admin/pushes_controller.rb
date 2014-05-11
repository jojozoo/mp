class Admin::PushesController < Admin::ApplicationController

  def tui
    obj  = Image.find_by_id_and_state(params[:id], true)
    render text: 'success' and return unless obj
    attrs = {
      obj_id: obj.id,
      obj_type: 'Image',
      channel: params[:channel],
      source_id: obj.id,
      source_type: 'Image'
    }
    if params[:channel] == '漫拍之星'
      attrs.merge!(source_id: obj.user_id, source_type: 'User')
    end
    if params[:channel] == '推荐摄影师'
      render text: '' and return unless obj.user.photographer
      attrs.merge!(source_id: obj.user_id, source_type: 'User')
    end
    @push = Push.where(attrs).first unless @push # 根据推荐摄影师和每日一图查询
    @push = Push.create!(attrs.merge(mark: '暂无备注')) unless @push
    render text: 'success'
  end

  def index
    p = params[:t].present? ? "obj_type = '#{params[:t]}' or source_type = '#{params[:t]}'" : {}
    @pushes = Push.where(p).paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  def new
    @push = Push.new
  end

  def edit
    @push = Push.find(params[:id])
  end

  def create
    @push = Push.new(params[:push])

    if @push.save
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  def update
    @push = Push.find(params[:id])

    if @push.update_attributes(params[:push])
      redirect_to action: :show, id: @push
    else
      render action: "edit"
    end
  end

  def destroy
    @push = Push.find(params[:id])
    @push.update_attributes(del: true)
    redirect_to :back
  end

end