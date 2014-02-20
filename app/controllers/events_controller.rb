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
			# TODO 创建完成应该跳转到活动show页面(未审核只允许创建者和管理员访问)，可以修改
			flash[:notice] = "活动创建成功,等待管理员审核"
			redirect_to events_path
		else
			render 'new'
		end
	end

	def show
		# TODO 自动跳转到404页面
		@event = Event.ongoing.find(params[:id])
		@works = @event.works.limit(20)
	end

	def edit

	end

	def update

	end

	def destroy
	end
end