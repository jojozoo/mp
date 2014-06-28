Resque.redis.namespace = "mpwang"

require 'resque/server'
require 'resque_scheduler/server'
# Resque::Server.use(Rack::Auth::Basic) do |user, password|
#      user     == 'mpwang'
#      password == 'mpwang123'
# end