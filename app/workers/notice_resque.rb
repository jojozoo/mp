class NoticeResque
	@queue = :notice
	
	def self.perform(notice_id)
		notice = Notice.find(notice_id)
		Notifier.notice(notice).deliver
	end

end