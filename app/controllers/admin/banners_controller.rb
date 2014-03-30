class Admin::BannersController < Admin::ApplicationController
    def index
        @banners = Sbanner.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @banner = Sbanner.find(params[:id])
    end

    def new
        @banner = Sbanner.new
    end

    def create
        @banner = Sbanner.new(params[:sbanner])
        if @banner.save
            redirect_to action: :index
        else
            render action: "new"
        end
    end

    def edit
        @banner = Sbanner.find(params[:id])
    end

    def update
       @banner = Sbanner.find(params[:id])
       if @banner.update_attributes(params[:sbanner])
            redirect_to action: :show, id: @banner.id
       else
            render action: "edit"
       end
    end

    def destroy
        @banner = Sbanner.find(params[:id])
        @banner.update_attributes(del: true)
        redirect_to admin_banners_path
    end

end