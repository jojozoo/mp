class HomeController < ApplicationController
	def index
		params[:order] = "recommend_at desc"
		@photos = Photo.where(recommend: true).paginate(:page => params[:page], per_page: 12).order(params[:order])
	end
end