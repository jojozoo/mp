class UsersController < ApplicationController

	def show
		@user   = User.find(params[:id])
		params[:order] = "id desc"
		@photos = @user.photos.where(state: true).paginate(:page => params[:page], per_page: 12).order(params[:order])
	end

	def fans
		@user = User.find(params[:id])
		@fans = @user.fans.paginate(:page => params[:page], per_page: 12)
	end

	def fols
		@user = User.find(params[:id])
		@fols = @user.fols.paginate(:page => params[:page], per_page: 12)
	end

	def like
		@user = User.find(params[:id])
		@tuis = Tui.where(editor_id: @user.id, obj_type: 'Photo').like.paginate(:page => params[:page], per_page: 12)
	end

	def store
		@user = User.find(params[:id])
		@tuis = Tui.where(editor_id: @user.id, obj_type: 'Photo').store.paginate(:page => params[:page], per_page: 12)
	end

	def messages
		
	end

	def talks

	end

	def notices

	end
end