kill -9 `cat tmp/pids/resque-scheduler.pid`
rake environment resque:scheduler PIDFILE='tmp/pids/resque-scheduler.pid' BACKGROUND=yes