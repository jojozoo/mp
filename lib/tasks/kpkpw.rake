require 'nokogiri'
require 'open-uri'
desc "获取kpkpw用户基本信息"
task :kpkpw => :environment do
	(11977..30000).each do |id|
		get id
	end
end
task :kpkpw1 => :environment do
	(35504..60000).each do |id|
		get(id)
	end
end
task :kpkpw2 => :environment do
	(63123..90000).each do |id|
		get(id)
	end
end
task :kpkpw3 => :environment do
	(94987..120000).each do |id|
		get(id)
	end
end
task :kpkpw4 => :environment do
	(133630..150000).each do |id|
		get(id)
	end
end
# 379100

def get id
	str = "http://www.kpkpw.com/space.php?do=info&uid=#{id}"
	document = Nokogiri::HTML(open(str))
	hash = {}
	hash[:url] = (document.search('.Personal_R .About_L img').first.attributes["src"].value rescue '')
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
	Info.create(hash)
end