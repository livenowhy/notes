## rsync 服务器之间代码同步 

## 前期准备

    服务器端: corevm.livenowhy.com
    客户端：192.168.0.2

## 安装rsync

    $ yum install rsync
    $ brew install rsync (mac)
    
## 服务器端配置
    
    corevm.livenowhy.com 服务器端配置 rsyncd.conf 文件
    yum 安装则是 vim /etc/rsyncd.conf
    
    [share]
    path=/share
    use chroot=true
    max connections=4
    # 指定该模块是否可读写，即能否上传文件，false表示可读写，true表示可读不可写。所有模块默认不可上传
    read only = false
    
    # 指定该模式是否支持下载，设置为true表示客户端不能下载。所有模块默认可下载
    write only = false
    list=true
    uid=root
    gid=root
    hosts allow=*
    ignore errors
    auth users=root
    secrets file=/etc/rsyncd.passwd
    
    $ netstat -lntp | grep 'rsync'
    $ ps uax | grep 'rsync'
    $ rsync --daemon --config=/etc/rsyncd.conf
    $ systemctl stop firewalld service     关闭防火墙
    $ systemctl disable firewalld.service  开机禁止防火墙服务器


## 配置密码
  
  `1` 服务器端的

    vim /etc/rsyncd.passwd ; 无则服务器端新建，输入以下内容：
    $ root:J2h6sRwzy
    
  `2` 客户端
  
    $ vim /etc/rsyncd.passwd，无则服务器端新建，输入以下内容：
    $ J2h6sRwzy   (注意前面没有用户名)
    
    密码文件需要 600 权限，改变权限
    $ chmod 600 /etc/rsyncd.passwd

## 在服务器端，以daemon模式运行

    rsync --daemon

## 配置 rsync 开机自启动
    
    $ chmod +x /etc/rc.d/rc.local
    $ mkdir -p /etc/rc.d/my
    $ vim /etc/rc.d/my/startrsync.sh
    内容
    rsync --daemon --config=/etc/rsyncd.conf

    $ chmod +x /etc/rc.d/my/startrsync.sh
    $ vim  /etc/rc.d/rc.local 
    添加 /etc/rc.d/my/startrsync.sh

## 同步文件

    同步本地文件到服务器(客户端执行)
    rsync -av  --progress  doc/ root@corevm.livenowhy.com::share/   --password-file=/share/rsyncd.passwd
    rsync -av  --progress  . root@corevm.livenowhy.com::share/  --password-file=/share/rsyncd.passwd

    同步服务器到本地
    rsync -zvrtopg --progress -e 'ssh -p  6665' root@172.16.0.99:/media/sdb/user/root/bin .
    当第一次同步之后，后面再有新的文件添加时使用
    rsync -azvrtopg --progress -e 'ssh -p  6665' root@172.16.0.99:/media/sdb/user/root/bin .
     

###

Rsync configure:
配置一：
ignore errors
说明：这个选项最好加上，否则再很多crontab的时候往往发生错误你也未可知，因为你不可能天天去看每时每刻去看log，不加上这个出现错误的几率相对会很高，因为任何大点的项目和系统，磁盘IO都是一个瓶颈
 
Rsync error： 
错误一： 
@ERROR: auth failed on module xxxxx 
rsync: connection unexpectedly closed (90 bytes read so far) 
rsync error: error in rsync protocol data stream (code 12) at io.c(150) 
说明：这是因为密码设置错了，无法登入成功，检查一下rsync.pwd，看客服是否匹配。还有服务器端没启动rsync 服务也会出现这种情况。

错误二： 
password file must not be other-accessible 
continuing without password file 
Password: 
说明：这是因为rsyncd.pwd rsyncd.sec的权限不对，应该设置为600。如：chmod 600 rsyncd.pwd

错误三： 
@ERROR: chroot failed 
rsync: connection unexpectedly closed (75 bytes read so far) 
rsync error: error in rsync protocol data stream (code 12) at io.c(150) 
说明：这是因为你在 rsync.conf 中设置的 path 路径不存在，要新建目录才能开启同步

错误四： 
rsync: failed to connect to 218.107.243.2: No route to host (113) 
rsync error: error in socket IO (code 10) at clientserver.c(104) [receiver=2.6.9] 
说明：防火墙问题导致，这个最好先彻底关闭防火墙，排错的基本法就是这样，无论是S还是C，还有ignore errors选项问题也会导致
 
错误五：
@ERROR: access denied to www from unknown (192.168.1.123)
rsync: connection unexpectedly closed (0 bytes received so far) [receiver]
rsync error: error in rsync protocol data stream (code 12) at io.c(359)
说明：此问题很明显，是配置选项host allow的问题，初学者喜欢一个允许段做成一个配置，然后模块又是同一个，致使导致

错误六：
rsync error: received SIGINT, SIGTERM, or SIGHUP (code 20) at rsync.c(244) [generator=2.6.9]
rsync error: received SIGUSR1 (code 19) at main.c(1182) [receiver=2.6.9]
说明：导致此问题多半是服务端服务没有被正常启动，到服务器上去查查服务是否有启动，然后查看下 /var/run/rsync.pid 文件是否存在，最干脆的方法是杀死已经启动了服务，然后再次启动服务或者让脚本加入系统启动服务级别然后shutdown -r now服务器

错误七：
rsync: read error: Connection reset by peer (104)
rsync error: error in rsync protocol data stream (code 12) at io.c(604) [sender=2.6.9]
说明：原数据目录里没有数据存在

错误八：
@ERROR: access denied to o2o from UNKNOWN (10.10.185.201)
rsync error: error starting client-server protocol (code 5) at main.c(1635) [sender=3.1.1]

说明：你建立的数据目录权限可能是root的。如果是root建立的，同步到另一台服务器上，权限不会同步过去的
