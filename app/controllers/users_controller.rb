class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def messages
		
	end

	def talks

	end

	def notices

	end
end