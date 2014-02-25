class ImagesController < ApplicationController
    def index
        @images = Image.where(state: true).paginate(:page => params[:page], per_page: 40).order('id desc')
    end

    def star
        @users = User.limit(10)
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
            send_path = image.picture.path(params[:style])
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
                url: @image.picture(:cover),
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

    def tui
        if sign_in?
            @image = Image.find(params[:id])
            binding.pry
            case params[:ac]
            when 'lauds'
                @image.lauds.create!(user_id: current_user.id)
                @count = @image.lauds_count
            when 'likes'
                @image.likes.create!(user_id: current_user.id)
                @count = @image.likes_count
            when 'stores'
                @image.stores.create!(user_id: current_user.id)
                @count = @image.stores_count
            else # 'recoms'
                @image.recoms.create!(user_id: current_user.id)
                @count = @image.recoms_count
            end
        else
            render js: "alert('请先登录')"
        end
    end
end