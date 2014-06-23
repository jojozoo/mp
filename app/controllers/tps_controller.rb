class TpsController < ApplicationController

    def create
        render text: 'not found', status: 404 and return unless sign_in?
        tp = Tp.create(user_id: current_user.id, picture: params[:filedata])
        data = {
            id: tp.id, 
            exif: JSON.parse(tp.exif),
            large: tp.picture(:large), 
            thumb: tp.picture(:thumb)
        }
        render json: data.to_json
    end

    def show
        render text: 'not found', status: 404 and return unless sign_in?
        tp = Tp.find_by_id(params[:id])
        if tp and (current_user.id.eql?(tp.user_id) or current_user.admin)
            send_file tp.picture.path(params[:style].to_sym), disposition: 'inline'
        else
            render text: request.path + 'not found', status: 404
        end
    end
end