class EventsController < ApplicationController
	def index
		@events = Event.ongoing.paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(params[:event].slice(:name, :logo, :title, :end_time, :tag, :text))
		if @event.save!
			redirect_to events_path
		else
			render 'new'
		end
	end

	def show
		@event = Event.ongoing.find(params[:id])
		redirect_to events_path and return if @event.blank?
		@works = @event.works.limit(20)
	end

	def edit

	end

	def update

	end

	def destroy
	end
end