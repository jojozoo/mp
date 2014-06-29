#! /bin/sh
kill -9 `cat tmp/pids/resque.pid`
nohup rake resque:work QUEUE='*' PIDFILE='tmp/pids/resque.pid' VERBOSE=yes &
kill -9 `cat tmp/pids/resque-scheduler.pid`
rake environment resque:scheduler PIDFILE='tmp/pids/resque-scheduler.pid' BACKGROUND=yes  VERBOSE=yes
