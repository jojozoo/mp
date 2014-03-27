class Admin::PushesController < Admin::ApplicationController

	def tui
		if @obj = Image.find(params[:id])
			p = case params[:source]
			when 'jx'
				Push.find_or_create_by_obj_id_and_obj_type_and_channel(@obj.id, 'Image', '每日精选')
			when 'yt'
				Push.find_or_create_by_obj_id_and_obj_type_and_channel(@obj.id, 'Image', '每日一图')
			when 'tj'
				Push.find_or_create_by_obj_id_and_obj_type_and_channel(@obj.id, 'Image', '编辑推荐')
			when 'st' # star漫拍之星
				Push.find_or_create_by_obj_id_and_obj_type_and_channel(@obj.user_id, 'User', '漫拍之星')
			end
			mark = mark_style(p.updated_at)
			p.update_attributes(user_id: current_user.id, mark: mark)
		end

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

end