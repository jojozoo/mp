class WorksController < ApplicationController
	def index
        @works = Work.paginate(:page => params[:page], per_page: 30).order('id desc')
    end

    def new
        redirect_to images_path, notice: '请先登录' and return unless sign_in?
        # TODO 应该加上event_id 或者 album_id 索引条件
        @images = current_user.images.where(state: false, del: false)
        unless @event  = Event.ongoing.find_by_id(params[:eid])
           @events = Event.ongoing.where(del: false).select('id, name')
        end
        
    end

    def create
        params[:work][:event_id] = params[:work_event_id]
        params[:work][:cover_id] = params[:desc].keys[0] if params[:work][:cover_id].blank?
        @work = current_user.works.create!(params[:work])

        # TODO 判断照片数量是否至少一张
        album   = current_user.albums.find_or_create_by_name('活动相册')
        warrant = params[:work][:warrant] || current_user.warrant
        current_user.images.where(["id in (?)", params[:desc].keys]).each do |image|
            desc = params[:desc][image.id.to_s]
            image.update_attributes(
                album_id: album.id, 
                event_id: params[:work][:event_id], 
                work_id: @work.id,
                state: true, 
                warrant: warrant, 
                desc: desc)
        end
        image_for_work_count = Image.where(work_id: @work.id).count
        @work.update_attributes(images_count: image_for_work_count)

        image_for_event_count = Image.where(event_id: params[:work][:event_id]).count
        work_for_event_count = Work.where(event_id: params[:work][:event_id]).count
        user_for_event_count = Work.uniq.where(event_id: params[:work][:event_id]).pluck(:user_id).length
        Event.find(params[:work][:event_id]).update_attributes(images_count: image_for_event_count, works_count: work_for_event_count, members_count: user_for_event_count)
        # TODO 最后跳转到作品展示页
        redirect_to action: :show, id: @work.id
    end

    def show
        @work = Work.find(params[:id])
        @work.visits.create(user_id: current_user.try(:id))
    end
end