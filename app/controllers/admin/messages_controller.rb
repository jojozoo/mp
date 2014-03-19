class Admin::MessagesController < Admin::ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.group(:talk).paginate(:page => params[:page], per_page: 20)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message  = Message.find_by_talk(params[:id])
    @messages = @message.inners.paginate(:page => params[:page], per_page: 20)
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.update_attributes(del: true)
    redirect_to admin_message_path(@message.talk)
  end
end