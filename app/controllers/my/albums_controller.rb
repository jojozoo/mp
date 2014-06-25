class My::AlbumsController < My::ApplicationController
	def index
        @albums = current_user.albums.paginate(:page => params[:page], per_page: 10).order('id desc')
	end

	def show
		@album = Album.find_by_id(params[:id])
        @photos = @album.photos.paginate(:page => params[:page], per_page: 20).order('id desc')
	end

    def create
        current_user.albums.create!(params[:album])
        flash[:notice] = "相册创建成功"
        redirect_to my_albums_path
    end

    def destroy
        @album = Album.find_by_id(params[:id])
        @album.photos.update_all("del = 1")
        @album.update_attributes(del: true)
        redirect_to my_albums_path
    end

    def new
        @album = Album.new
    end

    def edit
        @album = current_user.albums.find(params[:id])
    end

    def update
        album = current_user.albums.find(params[:id])
        album.update_attributes!(params[:album])
        flash[:notice] = "相册修改成功"
        redirect_to my_albums_path
    end

    # 编辑图片描述
    def desc
        if image = current_user.photos.find_by_id(params[:id])
            image.update_attributes desc: params[:desc]
        end
        render json: {text: '编辑成功', type: 'success'}.to_json
    end

    # 移动到的相册ID album_id or ids
    def move
        url, ids = if params[:ids].blank?
            [my_albums_path, nil]
        else
            [my_album_path(params[:id]), params[:ids].split(',')]
        end

        if params[:album_id].present?
            album_id, id = params[:album_id], params[:id]
            if ids
                current_user.photos.where(['album_id = ? and id in (?)', id, ids]).update_all(['album_id = ?', album_id])
            else
                current_user.photos.where(['album_id = ?', id]).update_all(['album_id = ?', album_id])
            end
        end
        flash[:notice] = "成功移动到其他相册"
        redirect_to url
    end

    def move_modal
        @album = current_user.albums.find(params[:id])
        @other = current_user.albums.where(['id <> ?', params[:id]])
    end
    
    # 封面
    def cover
        if album = current_user.albums.find_by_id(params[:id])
            if image = current_user.photos.find_by_id(params[:image_id])
                album.update_attributes logo: File.open(image.picture.path)
            end
        end
        render json: {text: '设置成功', type: 'success'}.to_json
    end
end