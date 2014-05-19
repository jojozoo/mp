desc "网站基本信息数据"
task :data => :environment do
	# users
	user = {
		avatar: File.open("public/system/images/thumb.1.jpg"),
		username: "朱晓武",
		email: "1@q.com",
		mobile: "18611149191",
		password: 'work123',
		password_confirmation: 'work123',
		admin: true
	}
	User.create(user)
	puts "start users"
	100.times do |index|
		hash = {
			avatar: File.open("public/system/images/thumb.#{index}.jpg"),
			username: "#{index}用户",
			email: "tmp#{index}@q.com",
			mobile: '186' + (11149191 + index).to_s[0..7],
			password: 'work123',
			password_confirmation: 'work123' 
		}
		hash.merge!(photographer: true) if index < 30
		User.create(hash)
	end
	puts "start events"
	# events
	50.times do |index|
		hash = {
			logo: File.open("public/system/images/thumb.#{index}.jpg"),
			name: "活动名称#{index}",
			title: "活动标题#{index}",
			end_time: 1.years.ago,
			channel: "未知#{index}",
			desc: "活动内容活动内容活动内容#{index}",
			state: 2,
			user_id: User.order("rand()").first.id
		}
		Event.create!(hash)
	end
	puts "start photos"
	# photos
	120.times do |index|
		hash = {
			user_id: User.order("rand()").first.id,
			event_id: Event.order("rand()").first.id,
			state: true,
			recommend: index % 2 == 0 ? true : false,
			recommend_at: Time.now,
			name: "image#{index}",
			title: "title#{index}",
			desc: "desc#{index}",
			picture: File.open("public/system/images/thumb.#{index}.jpg")
		}
		Photo.create(hash)
	end
end
