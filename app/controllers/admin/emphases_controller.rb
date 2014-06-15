class Admin::EmphasesController < Admin::ApplicationController
	def index
        @ems = Emphasis.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @em = Emphasis.find(params[:id])
    end

    def new
        @em = Emphasis.new
    end

    def create
        @em = Emphasis.new(params[:emphasis])
        if @em.save
            redirect_to action: :index
        else
            render action: "new"
        end
    end

    def edit
        @em = Emphasis.find(params[:id])
    end

    def update
       @em = Emphasis.find(params[:id])
       if @em.update_attributes(params[:emphasis])
            redirect_to action: :index
       else
            render action: "edit"
       end
    end

    def destroy
        @em = Emphasis.find(params[:id])
        @em.update_attributes(del: true)
        redirect_to admin_emphases_path
    end
end
