class ImagesController < ApplicationController
    
    def new

    end

    def show

    end

    def cut

    end

    def create
        @image = Image.create(picture: params[:Filedata], name: params[:Filename], user_id: User.first.id)
        # binding.pry
        json = {
            width: @image.picture.width, 
            height: @image.picture.height, 
            size: @image.picture.size,
            original: @image.picture.url
        }
        render json: json.to_json
    end
end