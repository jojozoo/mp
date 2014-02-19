class WorksController < ApplicationController


	def index

    end

    def new
        redirect_to events_path and return unless sign_in?
        # TODO 应该加上event_id 或者 album_id 索引条件
        @images = current_user.images.where(state: false, del: false)
        unless @event  = Event.ongoing.find_by_id(params[:eid])
           @events = Event.ongoing.where(del: false).select('id, name')
        end
        
    end

    def create
        album = current_user.albums.find_by_id(params[:album])
        # 封面
        if cover = current_user.images.find_by_id(params[:cover])
            album.update_attributes(logo: File.open(cover.picture.path(:cover)))
        end
        # 不需要查询
        event  = Event.find_by_id(params[:event])
        images = current_user.images.where(["id in (?)", params[:desc].keys]).each do |image|
            desc  = params[:desc][image.id.to_s]
            image.update_attributes(album_id: album.id, event_id: event.id, state: true, warrant: current_user.warrant, desc: desc)
            work = image.works.find_by_event_id_and_user_id(event.id, current_user.id)
            image.works.create(event_id: event.id, user_id: current_user.id, warrant: current_user.warrant, desc: desc) unless work
        end

        redirect_to event
    end
end