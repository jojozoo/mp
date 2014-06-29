#! /bin/sh
kill -9 `cat tmp/pids/resque.pid`
rake resque:work QUEUE='*' PIDFILE='tmp/pids/resque.pid' BACKGROUND=yes
