class Admin::TuisController < Admin::ApplicationController

  def index
    @tuis = Tui.where(p).paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  def new
    @tui = Tui.new
  end

  def edit
    @tui = Tui.find(params[:id])
  end

  def create
    @tui = Tui.new(params[:tui])

    if @tui.save
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  def update
    @tui = Tui.find(params[:id])

    if @tui.update_attributes(params[:tui])
      redirect_to action: :show, id: @tui
    else
      render action: "edit"
    end
  end

  def destroy
    @tui = Tui.find(params[:id])
    @tui.update_attributes(del: true)
    redirect_to :back
  end

end