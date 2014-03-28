class Admin::PushesController < Admin::ApplicationController

	def tui
		obj  = Image.find(params[:id])
		push = Push.find_or_create_by_obj_id_and_obj_type_and_channel(obj.id, 'Image', params[:source])
		if params[:source] == '漫拍之星'
			push.source = obj.user
		end
		if params[:source] == '推荐作品'
			
		end
		mark = mark_style(push.updated_at)
		push.update_attributes(user_id: current_user.id, mark: mark)
		render text: 'success'
	end

	def mark_style time
		de = time.to_date.to_s
		
		sx = case time.strftime("%H").to_i
		when 0..12
			'（上午版）'
		when 13..18
			'（下午版）'
		when 18..23
			'（晚上版）'
		else
			'（上午版）'
		end

		zj = case time.wday
		when 0
			'天'
		when 1
			'一'
		when 2
			'二'
		when 3
			'三'
		when 4
			'四'
		when 5
			'五'
		else
			'六'
		end
		de + sx + "【星期#{zj}】"
	end

	def index

	end

end