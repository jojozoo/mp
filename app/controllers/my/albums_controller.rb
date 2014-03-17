class My::AlbumsController < My::ApplicationController
	def index
        @albums = current_user.albums.paginate(:page => params[:page], per_page: 10).order('id desc')
	end

	def show
		@album = Album.find_by_id(params[:id])
        @images = @album.images.paginate(:page => params[:page], per_page: 20).order('id desc')
	end

    def create
        current_user.albums.create!(params[:album])
        redirect_to my_albums_path
    end

    def destroy
        @album = Album.find_by_id(params[:id])
        @album.images.update_all("del = 1")
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
        redirect_to my_albums_path
    end

    # 编辑图片描述
    # image_id, desc
    def desc

    end

    # id 移动到的相册ID
    # 当前相册album_id or ids
    # 移动
    def move

    end
    
    # 封面
    def cover
        if album = current_user.albums.find_by_id(params[:id])
            if image = current_user.images.find_by_id(params[:image_id])
                album.update_attributes logo: File.open(image.picture.path)
            end
        end
        render js: "alert('设置成功');" 
    end
end