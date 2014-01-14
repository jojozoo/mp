class UploadController < ApplicationController
    
    def new

    end

    def create
        # @image = Image.create(params[:image_avatar])
        # redirect_to :back
        # user.avatar_album.images.create()
        @image = Image.create(picture: params[:Filedata], name: params[:Filename], user_id: User.first.id)
        binding.pry
        render json: @image.picture.url
    end
end