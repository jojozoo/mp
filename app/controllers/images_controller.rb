class ImagesController < ApplicationController
    def index
        @objs = Image.where(del: false, state: true).paginate(:page => params[:page], per_page: 10).order('rand()')
        if request.xhr?
            render partial: 'row', collection: @objs, as: :image
            return
        end
    end

    def show
        @obj = Image.find_by_id_and_del_and_state(params[:id], false, true)
        redirect_to action: :index unless @obj
    end

    # 图片访问权限控制
    def browse
        # sleep(1)
        send_path = "public/system/#{params[:class]}/#{params[:id]}/#{params[:style]}/#{params[:random]}.#{params[:format]}"
        if params[:class].eql?('images') and image = Image.find_by_id(params[:id])
            send_path = image.picture.path
            if params[:style].eql?('original')
                if sign_in? and (current_user.id.eql?(image.user_id) or current_user.admin)
                    # 反着写
                else
                    render text: request.path + 'not found', status: 404 and return
                end
            end
        end
        send_file send_path, disposition: 'inline'
    end
    
    def new
        
    end

    def create
        redirect_to '/' and return unless sign_in?

        @image = current_user.images.create(picture: params[:Filedata], name: params[:Filename])
        data = {
                time: @image.created_at.to_s(:db),
                url: @image.picture.url(:cover),
                id: @image.id
            }
        render json: data.to_json
    end

    def destroy
        if image = Image.find_by_id(params[:id])
            image.update_attributes(del: true)
        end
        render text: 'ok'
    end
end