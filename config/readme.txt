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


标签搜索 组图浏览 继续上传


apt-get install pptpd
sudo vim /etc/pptpd.conf
localip 192.168.0.1
remoteip 192.168.0.234-238,192.168.0.245
sudo vim /etc/ppp/pptpd-options
找到带#ms-dns地方添加：
ms-dns 8.8.8.8 
ms-dns 8.8.4.4
sudo vim  /etc/ppp/chap-secrets
username    *   password    *
sudo vim /etc/sysctl.conf
net.ipv4.ip_forward=1
sudo sysctl -p


sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
or
sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source [你的服务器ip128.199.148.102]
apt-get install iptables
iptables -t nat -I POSTROUTING -j MASQUERADE
后面这句话作用是：立刻让LINUX支持NAT(platinum)

　iptables -I FORWARD -p tcp --syn -i ppp+ -j TCPMSS --set-mss 1356

假如有部分网站访问不正确，则加入这句，将MTU值调小，这句将MTU值设置为1356。

　但是，只是这样，iptables 的规则会在下次重启时被清除，所以我们还需要把它保存下来，方法是使用 iptables-save 命令：
   iptables-save > /etc/iptables-rules
然后修改 /etc/network/interfaces 文件，找到 eth0 那一节，在对 eth0 的设置最末尾加上下面这句：
    pre-up iptables-restore < /etc/iptables-rules
这样当网卡 eth0 被加载的时候就会自动载入我们预先用 iptables-save 保存下的配置。

sudo /etc/init.d/pptpd restart
mac 启动redis redis-server /usr/local/etc/redis.conf