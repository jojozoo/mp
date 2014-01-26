class My::AlbumsController < My::ApplicationController
	def index
	end

	def show
		@album = Album.find_by_id(params[:id])
	end
end