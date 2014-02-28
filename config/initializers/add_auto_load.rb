# 自动加载文件
auto_required_paths = %W(lib)

auto_required_paths.each do |dir|
  Dir["#{Rails.root}/#{dir}/*.rb"].each {|path| require path}
end