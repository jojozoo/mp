class EventsController < ApplicationController
	before_filter :must_login, only: [:new, :create, :edit, :update]
	def index
		@events = case params[:t]
		when 'ongoing'
			Event.ongoing
		when 'closed'
			Event.closed
		else
			con = params[:tag].present? ? {channel: params[:tag]} : {}
			Event.where('state > 1').where(con)
		end.paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def new
		@event = Event.new
	end

	def create
		params[:event][:desc] = params[:event][:desc].gsub(/<\/?.*?>/, "").gsub(/\r\n|\n/,"<br>") if params[:event][:desc].present?
		@event = Event.new(params[:event].slice(:name, :logo, :title, :end_time, :tag, :desc).merge(user_id: current_user.id))
		if @event.save!
			# TODO 创建完成应该跳转到活动show页面(未审核只允许创建者和管理员访问)，可以修改
			flash[:notice] = "活动创建成功,等待管理员审核"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def show
		@event = Event.find(params[:id])
		params[:q] ||= {n: 'news', o: 'updated_at desc', w: {request_id: @event.id}, s: 'line'}
	end

	def comment
		@event = Event.find(params[:id])
		params[:q] ||= {n: 'news', o: 'updated_at desc', w: {request_id: @event.id}, s: 'line'}
		@comments = @event.comments.paginate(:page => params[:page], per_page: 20).order('id desc')
	end

	def edit

	end

	def update

	end

	def destroy
	end
end