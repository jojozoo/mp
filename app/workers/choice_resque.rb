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
			title = Date.today.strftime("%Y年%m月%d日") + " 精选照片"
			MpSet.create(title: title, link: 'javascript:void(0);', src: choice.picture.url(:thumb), cate: 1, cate_id: 0)
		end
	end

end