class SetsController < ApplicationController
	def index
		redirect_to action: :basic
	end

	def basic
		render 'index'
	end

	def avatar
		render 'index'
	end

	def security
		render 'index'
	end

	def privacy
		render 'index'
	end

	def push
		render 'index'
	end

	def dy
		render 'index'
	end

	def bg
		render 'index'
	end
end