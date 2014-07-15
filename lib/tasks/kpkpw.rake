require 'nokogiri'
require 'open-uri'
desc "获取kpkpw用户基本信息"
task :kpkpwfile => :environment do
	File.read("ids").each_line do |id|
		get id
	end
end
task :kpkpw => :environment do
	(380243..381826).each do |id|
		get(id)
	end
end
# 379278

def get id
	str = "http://www.kpkpw.com/space.php?do=info&uid=#{id}"
	# begin
		document = Nokogiri::HTML(open(str))
		hash = {}
		hash[:url] = document.search('.Personal_R .About_L img').first.attributes["src"].value rescue ''
		tmp = {
			"username" => "昵称", 
			"local"    => "所在地", 
			"email"    => "Email", 
			"gender"   => "性别",
			"uid"      => "个性域名", 
			"site"     => "个人网站", 
			"desc"     => "简介", 
			"func"     => "职业", 
			"tag"      => "标签"
		}
		document.search('.Personal_R .About_R dl').each do |dl|
			key   = dl.search('dt').first.text.gsub("\n", "")
			value = dl.search('dd').first.text.gsub("\n", "")
			value = value.gsub("http://www.kpkpw.com/?", "") if key == "个性域名"
			hash[tmp.invert[key]] = value
		end
		hash = hash.slice(*["uid", "username", "local", "email"])
		hash['channel'] = 'kpkpw'
		ap hash
		unless hash["email"].blank?
			MailInvite.create(hash)
			ap "create"
		end
	# rescue
	# 	ap 'error'
	# end
end
