class HomeController < ApplicationController
	def index

	end

	def tags
		render json: {availableTags: Tag.limit(10).map(&:name), assignedTags: []}.to_json
	end
end