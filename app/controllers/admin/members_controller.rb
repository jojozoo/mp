class Admin::MembersController < Admin::ApplicationController

	def update
		@member = Member.find(params[:id])

		if @member.update_attributes(params[:member])
			flash[:notice] = "保存成功"
		else
			flash[:notice] = "保存失败"
		end
		redirect_to admin_event_path(@member.event_id)
	end

	def create
		@member = Member.new(params[:member])
		if @member.save
			flash[:notice] = "创建成功"
		else
			flash[:notice] = "创建失败"
		end
		redirect_to admin_event_path(@member.event_id)
	end

	def destroy
		@member = Member.find(params[:id])
		if @member.destroy
			flash[:notice] = "删除成功"
		else
			flash[:notice] = "删除失败"
		end
		redirect_to admin_event_path(@member.event_id)
	end
end