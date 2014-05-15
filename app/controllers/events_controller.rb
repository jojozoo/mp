class EventsController < ApplicationController
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
		@photos = load_data
	end

	def waterfall
        @photos = load_data
        render 'waterfall', layout: false
    end

    def load_data
    	@event = Event.find(params[:id])
    	if current_user
	    	stime = Date.today.to_s + ' 00:00:00'
			etime = Date.today.to_s + ' 23:59:59'
			@tuis = Tui.where(obj_type: 'Photo', user_id: current_user.id, channel: 'choice').where(["updated_at between ? and ?", stime, etime])
    	end
		order, cond = case params[:order]
		when 'news'
			['id desc', {}]
		when 'vist'
			['liks_count desc', {}]
		when 'coms'
			['coms_count desc', {}]
		when 'myse'
			c = sign_in? ? {user_id: current_user.id} : {}
			['id desc', c]
		else
			params[:order] = 'news'
			['id desc', {}]
		end
		@photos = @event.photos.where(cond).paginate(:page => params[:page], per_page: 24).order(order)
    end

	def edit

	end

	def update

	end

	def destroy
	end
end