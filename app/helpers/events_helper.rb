module EventsHelper
	def link_to_editer_recom image, event, tuiids
		member = Editor.find_by_event_id_and_editor_id(event.id, current_user.id)
		if member
			classstr = "push-editer-#{image.id}-link btn btn-success btn-xs btn-ajax "
			url      = "/ajax/editer/images/#{image.id}?eid=#{event.id}"
			tipstr   = "编辑推荐"

			if tuiids.member?(image.id)
				url += "&cancel=true"
				tipstr = "取消推荐"
			else
				if tuiids.length >= member.sum
					classstr = classstr + "disabled"
				end
			end
			link_to tipstr, url, class: classstr, remote: true, method: :post
		end
	end
end