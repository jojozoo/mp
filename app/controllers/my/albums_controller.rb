class My::AlbumsController < My::ApplicationController
	def index
        @albums = current_user.albums.paginate(:page => params[:page], per_page: 10).order('id desc')
	end

	def show
		@album = Album.find_by_id(params[:id])
        @images = @album.images.paginate(:page => params[:page], per_page: 10).order('id desc')
	end
end