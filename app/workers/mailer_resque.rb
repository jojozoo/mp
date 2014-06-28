class MailerResque
	@queue = :session_mail
	
	def self.perform(uid, forgot = false)
		user = User.find(uid)
		Notifier.sign_mail(user, forgot).deliver
	end

end