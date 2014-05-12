require 'nokogiri'
require 'open-uri'
desc "获取kpkpw用户基本信息"
task :kpkpwfile => :environment do
	File.read("ids").each_line do |id|
		get id
	end
end
task :kpkpw => :environment do
	(282900..379278).each do |id|
		get(id)
	end
end
# 379278

def get id
	str = "http://www.kpkpw.com/space.php?do=info&uid=#{id}"
	begin
		document = Nokogiri::HTML(open(str))
		hash = {}
		hash[:url] = document.search('.Personal_R .About_L img').first.attributes["src"].value
		tmp = {
			"nickname" => "昵称", 
			"local"    => "所在地", 
			"email"    => "Email", 
			"gender"   => "性别",
			"domain"   => "个性域名", 
			"site"     => "个人网站", 
			"desc"     => "简介", 
			"func"     => "职业", 
			"tag"      => "标签"
		}
		document.search('.Personal_R .About_R dl').each do |dl|
			key   = dl.search('dt').first.text.gsub("\n", "")
			value = dl.search('dd').first.text.gsub("\n", "")
			hash[tmp.invert[key]] = value
		end
		ap hash
		MailInvite.create(hash)
	rescue
		ap 'error'
	end
end
