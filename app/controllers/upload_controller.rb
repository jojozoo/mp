class UploadController < ApplicationController
    
    def new

    end

    def create
        @image = Image.create(params[:image_avatar])
        redirect_to :back
    end
end