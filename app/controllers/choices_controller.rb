class ChoicesController < ApplicationController
	def index
		@title = "推荐 - 漫拍网"
		@choices = MpSet.where(cate: 1).paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def show
		@today = params[:id].to_date rescue Date.today
		@title = "#{@today.strftime("%Y年%m月%d日")} 编辑推荐 - 推荐 - 漫拍网"
		s_dt = (@today.to_s(:number) + "000000").to_time
		e_dt = (@today.to_s(:number) + "235959").to_time
		@choices = Photo.where(["recommend = ? and recommend_at > ? and recommend_at < ?",  true, s_dt, e_dt]).order('id desc')
	end
end