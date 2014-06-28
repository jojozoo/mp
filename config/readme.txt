weibo : http://open.weibo.com/webmaster/build?siteid=3167481927 http://open.weibo.com/webmaster/console?siteid=3167481927
key: 3167481927
secret: 9d51bc64809281211735f0eef681f3e9
qq    : http://op.open.qq.com/index.php?mod=appinfo&act=main&appid=1101192136
qqmp  : http://dev.t.qq.com/development/appinfo?appid=1101192136&comefrom=1
在用
qzone : http://connect.qq.com/manage/appManager?appid=101016368&platform=web&category=site_info_logo
douban: http://developers.douban.com/apikey/apply
renren: http://app.renren.com/developers/newapp/264179/audit/appHome

qq 和 qqmp不行

日志地址 /var/log/mysql的地址 /opt/nginx/logs/nginx的地址
sudo vim /opt/logrotate.conf
/home/www/mp/log/production.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    dateext
    copytruncate
    noolddir
}
/opt/nginx/logs/*.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    dateext
    copytruncate
    noolddir
}
执行命令
sudo logrotate -f /etc/logrotate.conf

wget http://redis.googlecode.com/files/redis-2.8.12.tar.gz
tar -zxf redis-2.8.12.tar.gz
cd redis-2.8.12
make
sudo make install
make test

wget https://github.com/ijonas/dotfiles/raw/master/etc/init.d/redis-server
wget https://github.com/ijonas/dotfiles/raw/master/etc/redis.conf
sudo mv redis-server /etc/init.d/redis-server
sudo chmod +x /etc/init.d/redis-server
sudo mv redis.conf /etc/redis.conf

sudo mkdir -p /var/lib/redis
sudo mkdir -p /var/log/redis
sudo useradd --system --home-dir /var/lib/redis redis
sudo chown redis.redis /var/lib/redis
sudo chown redis.redis /var/log/redis

sudo /etc/init.d/redis-server start

resque启动
运行resque后台任务
QUEUE=* rake resque:work
通常是需要在自己应用的环境下来执行任务的
QUEUE=* rake environment resque:work
查看任务执行情况
#运行resque前台管理服务器
resque-web -p 8282


重启机器需要 启动nginx redis resque

定时任务失败
