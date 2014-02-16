class Admin::BannersController < Admin::ApplicationController
    def index
        @banners = Site::Banner.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @banner = Site::Banner.find(params[:id])
    end

    def new
        @banner = Site::Banner.new
    end

    def create

    end

    def edit
        @banner = Site::Banner.find(params[:id])
    end

    def update

    end

    def destroy

    end

end