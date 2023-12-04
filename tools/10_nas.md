## 群晖 nas ssh 登录

### 先期配置

    开启SSH功能: 控制面板 - 终端机和SNMP

### SSH 登陆

    $ ssh -p 922 liuzpnas@192.168.31.194
    $ 输入登陆密码

    切换至root账号
    $ sudo -i
    $ 输入登陆密码

    外网登陆
    ssh -oPort=6000 root@tx.livenowhy.com

### 安装软件
    $ wget http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/unstable/syno-i686-bootstrap_1.2-7_i686.xsh

    $ chmod +x syno-i686-bootstrap_1.2-7_i686.xsh
    $ sh syno-i686-bootstrap_1.2-7_i686.xsh
    $ ipkg update
    # ipkg install unzip
    # ipkg install make
    # ipkg install mysql-devel
    # ipkg install rsync

### 配置允许 root 直接登陆

    $ cd /etc/ssh

    给 sshd_config 赋予755的权限
    $ chmod 755 sshd_config

    $ vim sshd_config
    修改
    #PermitRootLogin prohibit-password
    为
    PermitRootLogin yes

    修改之后重启
    $ reboot

    修改root默认密码,xxx改为你要设置的密码，回车没有任何提示即可;
    $ synouser --setpw root xxx
    
## nas docker 配置
    
    使用北京区域
    registry.cn-beijing.aliyuncs.com
    
    群晖套件中心第三方源地址：http://packages.synocommunity.com

### 注册表设置
    
    docker login --username=hi35608059@aliyun.com registry.cn-beijing.aliyuncs.com