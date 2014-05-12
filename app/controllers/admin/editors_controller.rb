class Admin::EditorsController < Admin::ApplicationController

	def update
		@editor = Editor.find(params[:id])

		if @editor.update_attributes(params[:editor])
			flash[:notice] = "保存成功"
		else
			flash[:notice] = "保存失败"
		end
		redirect_to admin_event_path(@editor.event_id)
	end

	def create
		@editor = Editor.new(params[:editor])
		if @editor.save
			flash[:notice] = "创建成功"
		else
			flash[:notice] = "创建失败"
		end
		redirect_to admin_event_path(@editor.event_id)
	end

	def destroy
		@editor = Editor.find(params[:id])
		if @editor.destroy
			flash[:notice] = "删除成功"
		else
			flash[:notice] = "删除失败"
		end
		redirect_to admin_event_path(@editor.event_id)
	end
end