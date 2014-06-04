class HomeController < ApplicationController
	def index
		params[:order] = "recommend_at desc"
		@photos = Photo.where(recommend: true).paginate(:page => params[:page], per_page: 12).order(params[:order])
	end

	def tags
		render json: {availableTags: Tag.limit(10).map(&:name), assignedTags: []}.to_json
	end
end