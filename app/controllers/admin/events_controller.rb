class Admin::EventsController < Admin::ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.paginate(:page => params[:page], per_page: 20).order('id desc')
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event].merge(user_id: current_user.id))

    if @event.save
      redirect_to action: :index
    else
      render action: "new"
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to action: :show, id: @event
    else
      render action: "edit"
    end
  end

  def state
    if @event = Event.find(params[:id])
      @event.try(params[:val])
      redirect_to action: :show, id: @event.id
    else
      redirect_to action: :index
    end
  end

  def totop
    if @event = Event.find(params[:id])
      @event.update_attributes(totop: params[:val])
      redirect_to action: :show, id: @event.id
    else
      redirect_to action: :index
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.update_attributes(del: true)
    redirect_to admin_events_path
  end
end