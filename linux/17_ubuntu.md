### 更新 root 密码

    $ sudo passwd root

### 系统及软件更新

    $ sudo apt-get update  (更新 apt 资源)
    $ sudo apt-get upgrade (系统与软件更新)

### 生成密钥

    $ ssh-keygen -t rsa -b 4096 -C "ubuntu-vm@livenowhy.com"
    $ ssh -T git@github.com    (TEST github)

### ssh 配置

    $ apt install passwd openssl openssh-server openssh-client -y (安装ssh)

    $ vim /etc/ssh/sshd_config  (设置采用密码登录, 添加下面两行, 一般不需要配置就可以登陆)
    PermitRootLogin           yes
    PasswordAuthentication    yes
    上面注意的一点是 sshd_config 而不是 ssh_config 。
    
    $ service ssh restart  (重启sshd)

### 安装软件

    $ apt install curl vim vim-nox git cmake curl zip wget python3-pip -y
    $ pip3 install virtualenv


### 安装docker (参考其他文档)

### 安装其他软件

    $ apt-get install docker-compose -y
    $ apt-get install python3-dev default-libmysqlclient-dev build-essential gunicorn rar -y
    $ apt install nodejs npm
    $ npm install -g gitbook-cli
    $ gitbook -V
    

### 配置环境变量 (ubuntu 普通用户基础配置)

    PATH=$PATH:/home/liuzp/.local/bin
    export PATH
    
### 创建文件目录

    $ mkdir /share && chmod 777 /share/
    $ mkdir /share/github
    $ git clone

## mysql 

    $ sudo apt update
    $ sudo apt install mysql-server


## ubuntu 安装 mysql
    $ sudo apt-get install libmysqlclient-dev
    $ sudo apt-get install default-libmysqlclient-dev build-essential
    $ pip3 install mysqlclient

## 添加用户

    $ adduser guest
    $ adduser guest sudo
    $ usermod -s /bin/bash guest    # 为该用户指定命令解释程序(通常为/bin/bash)
    $ usermod -d /home/guest guest  # 为该用户指定用户主目录

    如果要删除用户
    $ deluser guest


### 如何保持Ssh长时间连接不断开

    ClientAliveInterval 8    # 每X秒向客户端发送一次保持连接的信号
    ClientAliveCountMax 4    # 表示客户端如果X次没有响应则断开连接
    $ service sshd restart