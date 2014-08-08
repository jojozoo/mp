class Admin::AjaxController < Admin::ApplicationController

	# /admin/ajax/:action?params[:update][:admin] = true || false
	# 默认参数为
	# update => 更新
	# where  => 查询
	def update
		obj = params[:source].classify.constantize.find_by_id(params[:id])
		if obj
			obj.update_attributes(params[:update])
		end
		redirect_to :back
	end

	def tui
		par = {obj_id: params[:id], obj_type: params[:source], channel: params[:channel], editor: true, editor_id: current_user.id, user_id:  params[:user_id]}
		tui = Tui.where(par).first
		
		Tui.create(par) unless tui
		
		obj = params[:source].classify.constantize.find_by_id(params[:id])
		if obj
			obj.update_attributes("#{params[:channel]}_at" => Time.now, params[:channel] => true)
		end
		redirect_to :back
	end

	def recommend
		s_dt = (Date.today.to_s + " 00:00:00").to_time
		e_dt = (Date.today.to_s + " 23:59:59").to_time
		choices = Photo.where(["recommend = ? and recommend_at > ? and recommend_at < ?",  true, s_dt, e_dt])
		if choices.length < 1
			flash[:notice] = "还没有推荐照片"
		else
			choice = choices.last
			title = Date.today.strftime("%Y年%m月%d日") + " 编辑推荐"
			if MpSet.find_by_title(title)
				flash[:notice] = "今天编辑推荐已经生成"
			else
				src = if choice.gl_id and choice.isgroup and choice.parent_id.blank?
					Photo.find_by_id(choice.gl_id).picture.url(:large) rescue choice.picture.url(:large)
				else
					choice.picture.url(:large)
				end
				MpSet.create(title: title, link: 'http://mpwang.cn/choices/' + Date.today.to_s(:number), src: src, cate: 1, cate_id: 0)
				flash[:notice] = "今天编辑推荐生成成功"
			end
		end
		redirect_to :back
	end

end