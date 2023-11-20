## docker 安装及配置

### centos 安装 docker

    1、Uninstall old versions
    yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    
    2、Set up the repository
    yum install -y yum-utils
    
    # yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    
    # 使用 aliyun (但是可能存在版本问题)
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
    3、Install Docker Engine
    yum install -y docker-ce docker-ce-cli containerd.io
    
    4、Start Docker.
    systemctl start docker
    
    5、开机启动docker
    systemctl enable docker


### ubuntu 安装 docker
    1、安装前准备 清除历史遗留
    $ sudo apt install gnome-terminal -y
    $ sudo apt remove docker-desktop -y
    $ rm -r $HOME/.docker/desktop
    $ sudo rm /usr/local/bin/com.docker.cli
    $ sudo apt purge docker-desktop

    2、安装
    2.1 Set up the repository
    2.1.1 Update the apt package index and install packages to allow apt to use a repository over HTTPS:
    $ sudo apt-get update -y
    $ sudo apt-get install ca-certificates curl gnupg -y

    2.1.2 Add Docker’s official GPG key:
    $ sudo install -m 0755 -d /etc/apt/keyrings
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    $ sudo chmod a+r /etc/apt/keyrings/docker.gpg

    2.1.3 Use the following command to set up the repository:
    $ echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

    2.2 Install Docker Engine
    $ sudo apt-get update
    $ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    
   
## 登陆阿里云仓库

    $ docker login --username=hi35608059@aliyun.com registry.cn-zhangjiakou.aliyuncs.com

    $ docker login --username=hi35608059@aliyun.com registry.cn-hangzhou.aliyuncs.com

    $ docker login --username=hi35608059@aliyun.com registry.cn-beijing.aliyuncs.com
    

## 配置镜像代理

    $ mkdir -p /etc/docker
    
    $ tee /etc/docker/daemon.json <<-'EOF'
    {
        "registry-mirrors": ["https://5y127n6j.mirror.aliyuncs.com"]
    }
    EOF

## 修改镜像存储位置

  $ vi /usr/lib/systemd/system/docker.service
  ExecStart=/usr/bin/dockerd --graph /bigdata/docker
  $ systemctl daemon-reload
  $ systemctl restart docker.service