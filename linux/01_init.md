## centos 环境配置

## 更新系统

    $ yum update -y
    $ yum upgrade -y
    
### 解决 Centos 不能联网且 ifconfig 出现 command not found
    
    $ ip addr  (ifconfig 不可用， 使用 ip addr 查看网卡分配)

    1、激活网卡:
    $ vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
    
    将 ONBOOT=no 改为 ONBOOT=yes

    2、保存后重启网卡
    $ service network restart   此时就可以上网了

### 免密码登陆

  `a` 生成秘钥

    $ ssh-keygen -t rsa -b 4096 -C "liuzp-a@livenowhy.com"
    $ ssh -T git@github.com    (TEST github)

    
    $ ssh-keygen -t ed25519 -C "mac@livenowhy.com"

    查看密钥: cat ~/.ssh/id_ed25519.pub
    复制密钥: pbcopy < ~/.ssh/id_ed25519.pub

  `b` 配置 sshd
  
    $ vim /etc/ssh/sshd_config -->去掉下面三行的注释
    RSAAuthentication yes
    PubkeyAuthentication yes
    AuthorizedKeysFile      .ssh/authorized_keys

  `c` 添加文件

    $ chmod 600 authorized_keys
    $ service sshd restart   --> 重启ssh服务
  
## 安装编译相关工具及常用软件:
    $ yum -y groupinstall "Development tools"
    # git、gcc、gcc-c++、rsync、zlib-devel、openssl-devel
    $ yum install -y vim
    $ yum install -y wget
    $ yum install -y net-tools
    $ yum install -y epel-release   # 安装 EPEL 软件源
    $ yum install -y python36
    $ yum install -y python36-devel
    $ yum install -y openldap-devel 
    $ yum install -y unixODBC-devel
    $ yum install -y python-devel
    $ yum install -y MySQL-python
    $ yum install -y python-simplejson
    $ yum install -y mysql-devel
    $ yum install -y bzip2-devel
    $ yum install -y ncurses-devel
    $ yum install -y sqlite-devel
    $ yum install -y readline-devel
    $ yum install -y tk-devel
    $ yum install -y gdbm-devel
    $ yum install -y db4-devel
    $ yum install -y libpcap-devel
    $ yum install -y xz-devel
    $ yum install -y libffi-devel
    $ yum install -y docker-compose
    $ yum clean all

### 创建需要的目录
    $ mkdir /share
    $ chmod a+wr /share

    # docker 镜像存储地址
    $ mkdir -p /bigdata/docker
    $ chmod -R a+wr /bigdata/docker

    # mongo 存储数据
    $ mkdir -p /bigdata/mongo
    $ chmod -R a+wr /bigdata/mongo

    # mysql 存储数据
    $ mkdir -p /bigdata/mysql
    $ chmod -R a+wr /bigdata/mysql

    # rabbitmq 存储数据
    $ mkdir -p /bigdata/rabbitmq
    $ chmod -R a+wr /bigdata/rabbitmq

    # mongo 存储数据
    # mkdir -p /bigdata/mongo
    # chmod -R a+wr /bigdata/mongo