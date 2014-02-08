class AlbumsController < ApplicationController


    def create
        @album = current_user.albums.create!(params[:album])
    end
end