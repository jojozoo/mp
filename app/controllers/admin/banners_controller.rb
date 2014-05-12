class Admin::BannersController < Admin::ApplicationController
    def index
        @banners = Banner.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @banner = Banner.find(params[:id])
    end

    def new
        @banner = Banner.new
    end

    def create
        @banner = Banner.new(params[:banner])
        if @banner.save
            redirect_to action: :index
        else
            render action: "new"
        end
    end

    def edit
        @banner = Banner.find(params[:id])
    end

    def update
       @banner = Banner.find(params[:id])
       if @banner.update_attributes(params[:banner])
            redirect_to action: :show, id: @banner.id
       else
            render action: "edit"
       end
    end

    def destroy
        @banner = Banner.find(params[:id])
        @banner.update_attributes(del: true)
        redirect_to admin_banners_path
    end

end