class ChannelsController < ApplicationController
	def index
		@channels = case params[:t]
		when 'ongoing'
			Event.where(ischannel: true).ongoing
		when 'closed'
			Event.where(ischannel: true).closed
		else
			con = params[:tag].present? ? {channel: params[:tag]} : {}
			Event.where('state > 1 and ischannel = 1').where(con)
		end.paginate(:page => params[:page], per_page: 12).order('id desc')
	end

	def show
		@channel = Event.find(params[:id])
		params[:q] ||= {n: 'news', o: 'id desc', w: {request_id: @channel.id}, s: 'line'}
	end

	def comment
		@channel = Event.find(params[:id])
		params[:q] ||= {n: 'news', o: 'id desc', w: {request_id: @channel.id}, s: 'line'}
		@comments = @channel.comments.paginate(:page => params[:page], per_page: 20).order('id desc')
	end
end