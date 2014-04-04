class Admin::ImagesController < Admin::ApplicationController

	def index
		# Date.today.beginning_of_day
		# Date.today.end_of_day
		params[:date] = params[:date] || Date.today.to_s
		params[:time] = params[:time] || '上午'
		s_dt, e_dt = datetime_merge(params[:date], params[:time])
		@images = Image.where(['created_at >= ? and created_at <= ?', s_dt, e_dt]).paginate(:page => params[:page], per_page: 24)
	end

	def datetime_merge date, time
		arr = case time
		when '下午'
			[date + ' 13:00:00', date + ' 18:59:59']
		when '晚上'
			[date + ' 19:00:00', date + ' 23:59:59']
		else
			[date + ' 00:00:00', date + ' 12:59:59']
		end
		arr.map{|t| t.to_time(:local)}
	end

	def basic
		@image = Image.find(params[:id])
		render :basic, layout: false
	end

	def all
		@images = Image.where(params[:con]).paginate(:page => params[:page], per_page: 20).includes([:user, :event, :work, :album])
	end

	def show
		@image = Image.find(params[:id])
	end

	def destroy
		
	end
end