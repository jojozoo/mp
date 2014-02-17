class Sendmin::SendsController < Admin::ApplicationController
    def index
        @sends = Send.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @send = Send.find(params[:id])
    end

    def new
        @send = Send.new
    end

    def create
        @send = Send.new(params[:send])
        if @send.save
            redirect_to action: :index, notice: '创建成功'
        else
            render action: "new"
        end
    end

    def edit
        @send = Send.find(params[:id])
    end

    def update
       @send = Send.find(params[:id])
       if @send.update_attributes(params[:send])
            redirect_to action: :show, id: @send.id, notice: '创建成功'
       else
            render action: "edit"
       end
    end

    def destroy
        @send = Send.find(params[:id])
        @send.update_attributes(del: true)
        redirect_to admin_sends_path
    end

end