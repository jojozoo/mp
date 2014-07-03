class UsersController < ApplicationController
	before_filter :get_user

	def show
		@user = User.find(params[:id])
		params[:q] ||= {n: 'news', o: 'id desc', s: 'cols', w: {user_id: @user.id}}
		params[:q][:s] = 'cols'
		# @photos = @user.photos.where(state: true).paginate(:page => params[:page], per_page: 12).order(params[:order])
	end

	def fans
		@fans = @user.fans.paginate(:page => params[:page], per_page: 12)
	end

	def fols
		@fols = @user.fols.paginate(:page => params[:page], per_page: 12)
	end

	def like
		@tuis = Tui.where(editor_id: @user.id, obj_type: 'Photo').liks.paginate(:page => params[:page], per_page: 12)
	end

	def store
		@tuis = Tui.where(editor_id: @user.id, obj_type: 'Photo').stos.paginate(:page => params[:page], per_page: 12)
	end

	def albums
		if current_user and current_user.id.eql?(@user.id)
			redirect_to my_albums_path
		else
			@albums = @user.albums.paginate(:page => params[:page], per_page: 12)
		end
	end

	def photos
		@album = @user.albums.find(params[:album_id])
		@photos = @album.photos.paginate(:page => params[:page], per_page: 12)
	end

	def messages
		
	end

	def talks

	end

	def notices

	end

	private
	def get_user
		@user = User.find_by_id(params[:id])
		render text: 'not found', status: 404 and return unless @user
	end
end