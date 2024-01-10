#!/bin/bash
## 更新系统
yum update -y
yum upgrade -y
## 安装编译相关工具及常用软件:
yum -y groupinstall "Development tools"
yum install -y vim
yum install -y wget
yum install -y net-tools
# 安装 EPEL 软件源
yum install -y epel-release  
yum install -y python36
yum install -y python36-devel
yum install -y openldap-devel 
yum install -y unixODBC-devel
yum install -y python-devel
yum install -y MySQL-python
yum install -y python-simplejson
yum install -y mysql-devel
yum install -y bzip2-devel
yum install -y ncurses-devel
yum install -y sqlite-devel
yum install -y readline-devel
yum install -y tk-devel
yum install -y gdbm-devel
yum install -y db4-devel
yum install -y libpcap-devel
yum install -y xz-devel
yum install -y libffi-devel
yum install -y nginx
yum update -y
yum upgrade -y
yum clean all

### 创建需要的目录
mkdir /share
chmod a+wr /share

# docker 镜像存储地址
mkdir -p /bigdata/docker
chmod -R a+wr /bigdata/docker

# mongo 存储数据
mkdir -p /bigdata/mongo
chmod -R a+wr /bigdata/mongo

# mysql 存储数据
mkdir -p /bigdata/mysql
chmod -R a+wr /bigdata/mysql

# rabbitmq 存储数据
mkdir -p /bigdata/rabbitmq
chmod -R a+wr /bigdata/rabbitmq

# mongo 存储数据
mkdir -p /bigdata/mongo
chmod -R a+wr /bigdata/mongo


## docker
# Uninstall old versions
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# Set up the repository
yum install -y yum-utils

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
yum install -y docker-ce docker-ce-cli containerd.io

# Start Docker.
systemctl start docker

# 开机启动docker
systemctl enable docker

# 配置镜像代理
mkdir -p /etc/docker
    
tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://5y127n6j.mirror.aliyuncs.com"]
}
EOF