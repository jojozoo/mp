class UeditorsController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create]
	def index
		res = case params[:qaction]
		when 'config'
			{
				# imageUrl: "/system/ueditors/",
				# imagePath: "/system/ueditors/",
				imageFieldName: "upfile",
				# imageMaxSize: 2048,
				imageAllowFiles: [".png", ".jpg", ".jpeg", ".gif", ".bmp"],
				imagePathFormat: "{yyyy}-{mm}-{dd}_-{hh}-{ii}-{ss}-{rand:6}_{filename}",

				imageManagerActionName: "listimage", 
				imageManagerListPath: "/system/ueditors/",
				imageManagerListSize: 20, 
				imageManagerUrlPrefix: "", 
				imageManagerInsertAlign: "none", 
				imageManagerAllowFiles: [".png", ".jpg", ".jpeg", ".gif", ".bmp"], 
				fileActionName: "uploadfile", #/* controller里,执行上传视频的action名称 */
				fileFieldName: "upfile", #/* 提交的文件表单名称 */
				filePathFormat: "/system/ueditors/", #/* 上传保存路径,可以自定义保存路径和文件名格式 */
				fileUrlPrefix: "", #/* 文件访问路径前缀 */
				fileMaxSize: 51200000, # /* 上传大小限制，单位B，默认50MB */
				fileAllowFiles: [
					".png", ".jpg", ".jpeg", ".gif", ".bmp",
					".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
					".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
					".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
					".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
				] #上传文件格式显示
			}
		when 'listimage'
			page = params[:start].to_i / 20
			page = 1 if page.zero?
			us = Ueditor.where(user_id: current_user.id).paginate(:page => page, per_page: params[:size] || 20)
			{
				state: "SUCCESS",
				list: us.map{|u| {url: u.picture.url}},
				start: params[:start],
				total: us.total_entries
			}
		when ''
		else
		end
		render json: res.to_json
	end

	def create
		ue = Ueditor.create(picture: params[:upfile], user_id: current_user.id)
		res = {
			state: "SUCCESS",
			url: ue.picture.url,
			title: ue.picture_file_name,
			original: ue.picture.url
		}
		render json: res.to_json
	end
end
