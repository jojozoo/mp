class Admin::AdsController < Admin::ApplicationController
    def index
        @ads = Ad.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @ad = Ad.find(params[:id])
    end

    def new
        @ad = Ad.new
    end

    def create
        @ad = Ad.new(params[:ad])
        if @ad.save
            redirect_to action: :index
        else
            render action: "new"
        end
    end

    def edit
        @ad = Ad.find(params[:id])
    end

    def update
       @ad = Ad.find(params[:id])
       if @ad.update_attributes(params[:ad])
            redirect_to action: :show, id: @ad.id
       else
            render action: "edit"
       end
    end

    def putin
        if @ad = Ad.find(params[:id])
           @ad.putins.create(params[:putin])
        end
        redirect_to action: :show, id: @ad.id
    end

    def close
        if @ad = Ad.find(params[:id])
           @ad.putins.find(params[:pid]).update_attributes(state: true)
        end
        redirect_to action: :show, id: @ad.id
    end

    def open
        if @ad = Ad.find(params[:id])
           @ad.putins.find(params[:pid]).update_attributes(state: false)
        end
        redirect_to action: :show, id: @ad.id
    end

    def del
        if @ad = Ad.find(params[:id])
           @ad.putins.find(params[:pid]).update_attributes(del: true)
        end
        redirect_to action: :show, id: @ad.id
    end

    def destroy
        @ad = Ad.find(params[:id])
        @ad.update_attributes(del: true)
        redirect_to admin_ads_path
    end

end