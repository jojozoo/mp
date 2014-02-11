class EventsController < ApplicationController
	def index
		@events = Event.ongoing.paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def new
		unless sign_in?
			flash[:notice] = "登录用户才可以创建活动"
			redirect_to action: :index and return
		end
		@event = Event.new
	end

	def create
		unless sign_in?
			flash[:notice] = "登录用户才可以创建活动"
			redirect_to action: :index and return
		end
		@event = Event.new(params[:event].slice(:name, :logo, :title, :end_time, :tag, :desc).merge(user_id: current_user.id))
		if @event.save!
			flash[:notice] = "活动创建成功,等待管理员审核"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def show
		@event = Event.ongoing.find(params[:id])
		redirect_to events_path and return if @event.blank?
		@works = @event.works.limit(20)
	end

	def edit

	end

	def update

	end

	def destroy
	end
end