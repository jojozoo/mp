class Admin::PhotosController < Admin::ApplicationController

	def index
		params[:date] = params[:date] || Date.today.to_s
		params[:time] = params[:time] || '全天'
		s_dt, e_dt = datetime_merge(params[:date], params[:time])
		@photos = if params[:order].eql?('recommend')
			Photo.where(['recommend = ? and created_at >= ? and created_at <= ?', true, s_dt, e_dt]).paginate(:page => params[:page], per_page: 24).order("recommend_at desc")
		elsif params[:order].eql?('choice')
			Photo.where(['choice = ? and choice_at >= ? and choice_at <= ?', true, s_dt, e_dt]).paginate(:page => params[:page], per_page: 24).order("choice_at desc")
		else
			# Photo.where(['created_at >= ? and created_at <= ?', s_dt, e_dt]).paginate(:page => params[:page], per_page: 24).order("id desc")
			Photo.where(['(isgroup = ? and parent_id is not null or isgroup = ? and parent_id is null) and created_at >= ? and created_at <= ?', true,  false, s_dt, e_dt]).paginate(:page => params[:page], per_page: 24).order("id desc")
		end
	end

	def datetime_merge date, time
		arr = case time
		when '上午'
			[date + ' 00:00:00', date + ' 12:59:59']
		when '下午'
			[date + ' 13:00:00', date + ' 18:59:59']
		when '晚上'
			[date + ' 19:00:00', date + ' 23:59:59']
		else
			[date + ' 00:00:00', date + ' 23:59:59']
		end
		arr.map{|t| t.to_time(:local)}
	end

	def basic
		@photo = Photo.find(params[:id])
		render :basic, layout: false
	end

	def all
		@photos = Photo.where(params[:con]).paginate(:page => params[:page], per_page: 20).includes([:user, :event, :work, :album]).order("id desc")
	end

	def show
		@photo = Photo.find(params[:id])
	end

	def destroy
		
	end
end