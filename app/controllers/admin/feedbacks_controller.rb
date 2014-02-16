class Admin::FeedbacksController < Admin::ApplicationController
    def index
        @fbs = Feedback.paginate(:page => params[:page], per_page: 20).order('id desc')
    end

    def show
        @fb = Feedback.find(params[:id])
    end
end