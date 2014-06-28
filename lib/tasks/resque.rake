require 'resque/tasks'
require 'resque_scheduler/tasks'
task "resque:setup" => :environment
namespace :resque do
  task :setup do
    Resque.schedule = YAML.load_file('config/scheduler.yml')
  end
end