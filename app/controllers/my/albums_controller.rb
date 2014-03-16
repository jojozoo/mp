class My::AlbumsController < My::ApplicationController
	def index
        @albums = current_user.albums.paginate(:page => params[:page], per_page: 10).order('id desc')
	end

	def show
		@album = Album.find_by_id(params[:id])
        @images = @album.images.paginate(:page => params[:page], per_page: 20).order('id desc')
	end

    def create
        current_user.albums.create!(params[:album])
        redirect_to my_albums_path
    end

    def destroy
        @album = Album.find_by_id(params[:id])
        @album.update_attributes(del: true)
        redirect_to my_albums_path
    end
end