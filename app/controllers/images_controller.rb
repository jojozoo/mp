class ImagesController < ApplicationController
    def index
        @objs = Image.paginate(:page => params[:page], per_page: 10).order('rand()')
        if request.xhr?
            render partial: 'row', collection: @objs, as: :image
            return
        end
    end

    def show
        @obj = Image.find_by_id(params[:id])
    end

    # 图片访问权限控制
    def browse
        # sleep(1)
        send_path = "public/system/#{params[:class]}/#{params[:id]}/#{params[:style]}/#{params[:random]}.#{params[:format]}"
        if params[:class].eql?('images') and params[:style] and params[:style].eql?('original')
            redirect_to '/404' and return
        end
        send_file send_path, disposition: 'inline'
    end
    
    def new
        @event = Event.find_by_id(params[:eid])
    end

    def create
        redirect_to '/' and return unless sign_in?

        @image = current_user.images.create(picture: params[:Filedata], name: params[:Filename])
        data = {
                time: @image.created_at.to_s(:db),
                url: @image.picture.url(:cover)
            }
        render json: data.to_json
    end
end