class Admin::ImagesController < Admin::ApplicationController
	def index
		# Date.today.beginning_of_day
		# Date.today.end_of_day
		date   = params[:date]  || Date.today.to_s
		s_time = params[:stime] || '00:00:00'
		e_time = params[:etime] || '59:59:59'
		
		@images = Image.between(date + ' ' + s_time, date + ' ' + e_time)
	end

	def tasks
		
	end
end