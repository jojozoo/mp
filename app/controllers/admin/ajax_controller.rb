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
end