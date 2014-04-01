Resque.redis.namespace = "mpwang"

require 'resque/server'
Resque::Server.use(Rack::Auth::Basic) do |user, password|
     user     == 'mpwang'
     password == 'mpwang123'
end