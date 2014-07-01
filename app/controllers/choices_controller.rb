class ChoicesController < ApplicationController
	def index
		@choices = MpSet.where(cate: 1).paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def show
		@today = params[:id].to_date rescue Date.today
		s_dt = (@today.to_s(:number) + "000000").to_time
		e_dt = (@today.to_s(:number) + "235959").to_time
		@choices = Photo.where(["recommend = ? and recommend_at > ? and recommend_at < ?",  true, s_dt, e_dt]).paginate(:page => params[:page], per_page: 12).order('id desc')
	end
end