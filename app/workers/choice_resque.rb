class ChoiceResque
	@queue = :choice
	
	def self.perform
		s_dt = (Date.today.to_s + " 00:00:00").to_time
		e_dt = (Date.today.to_s + " 23:59:59").to_time
		choices = Photo.where(["recommend = ? and recommend_at > ? and recommend_at < ?",  true, s_dt, e_dt])
		if choices.length < 1
			Notifier.choice_mail.deliver
		else
			choice = choices.last
			title = Date.today.strftime("%Y年%m月%d日") + " 编辑推荐"
			unless MpSet.find_by_title(title)
				src = if choice.gl_id and choice.isgroup and choice.parent_id.blank?
					Photo.find_by_id(choice.gl_id).picture.url(:thumb) rescue choice.picture.url(:thumb)
				else
					choice.picture.url(:thumb)
				end
				MpSet.create(title: title, link: 'http://mpwang.cn/choices/' + Date.today.to_s(:number), src: src, cate: 1, cate_id: 0)
			end
		end
	end

end