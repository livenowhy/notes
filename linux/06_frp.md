## frp

### 程序下载

    $ wget https://github.com/fatedier/frp/releases/download/v0.37.1/frp_0.37.1_linux_386.tar.gz
    $ tar zxvf frp_0.37.1_linux_386.tar.gz

### 根据 notes 文件配置

    服务端配置 (有外网ip的)
    $ mkdir /etc/frp/
    # /Users/zpliu/Desktop/notes/linux/frp/frpc.ini
    $ cp /share/notes/public/linux/config/frp/systemd/frps.service /etc/systemd/system/frps.service
    $ cp /share/notes/public/linux/config/frp/frps.ini /etc/frp/frps.ini
    $ cp /share/notes/public/linux/config/frp/frps /usr/bin/frps
    
    # 刷新服务列表
    $ systemctl daemon-reload

    # 设置开机自启
    $ systemctl enable frps
    
    # 关闭开机自启
    $ systemctl disable frps

    # 启动服务
    $ systemctl start frps
    
    # 停止服务
    $ systemctl stop frps
    # 服务状态
    $ systemctl status frps
    
    客户端
    $ mkdir /etc/frp/

    /share/notes/public/linux/config
    $ cp /share/notes/public/linux/config/frp/systemd/frpc.service /etc/systemd/system/frpc.service
    $ cp /share/notes/public/linux/config/frp/frpc.ini /etc/frp/frpc.ini
    $ cp /share/notes/public/linux/config/frp/frpc /usr/bin/frpc
    
    # 测试
    $ /usr/bin/frpc -c /etc/frp/frpc.ini
    
    $ ssh -oPort=8084 root@xxx.xxx.xxx 外网地址
    
    设置开机启动
    
    # 刷新服务列表
    $ systemctl daemon-reload

    # 设置开机自启
    $ systemctl enable frpc
    
    # 关闭开机自启
    $ systemctl disable frpc

    # 启动服务
    $ systemctl start frpc
    
    # 停止服务
    $ systemctl stop frpc
    # 服务状态
    $ systemctl status frpc
    