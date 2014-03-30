class Admin::PushesController < Admin::ApplicationController

  def tui
    obj  = Image.find(params[:id])
    attrs = {
      obj_id: obj.id,
      obj_type: 'Image',
      channel: params[:channel]
    }
    if params[:channel] == '漫拍之星'
      attrs.merge!(source_id: obj.user_id, source_type: 'User')
    end
    if params[:channel] == '推荐作品'
      attrs.merge!(source_id: obj.work_id, source_type: 'Work')
    end
    push = Push.where(attrs).first
    push = Push.create!(attrs) unless push
    
    # mark = mark_style(push.updated_at)
    # push.update_attributes(user_id: current_user.id, mark: mark)
    render text: 'success'
  end

  def mark_style time
    de = time.to_date.to_s
    
    sx = case time.strftime("%H").to_i
    when 0..12
      '（上午版）'
    when 13..18
      '（下午版）'
    when 18..23
      '（晚上版）'
    else
      '（上午版）'
    end

    zj = case time.wday
    when 0
      '天'
    when 1
      '一'
    when 2
      '二'
    when 3
      '三'
    when 4
      '四'
    when 5
      '五'
    else
      '六'
    end
    de + sx + "【星期#{zj}】"
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