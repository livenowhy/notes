## 安装第三方软件
    
    把安装包放在 /share/soft 下

### 1、QQ

    $ wget https://dldir1.qq.com/qqfile/qq/QQNT/2355235c/linuxqq_3.1.1-11223_amd64.deb
    $ sudo apt install ./linuxqq_3.1.1-11223_amd64.deb 

    https://im.qq.com/linuxqq/index.shtml

### 2、Chrome 浏览器

    $ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    $ sudo dpkg -i google-chrome-stable_current_amd64.deb
    $ sudo apt-get -f install

    配置 google 账号 (配置之前在软件中心安装 shadowsocks)

### 3、安装 vscode

    $ wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64

    $ sudo apt install ./code_1.77.3-1681292746_amd64.deb

    1、登陆账号
    2、使用 hotmail 配置 Online Accounts

### 4、edge 浏览器(内存占用少)

    $ sudo apt install ./microsoft-edge-stable_112.0.1722.58-1_amd64.deb

    1、登陆账号

### 5、pycharm 安装配置

    1、Professional 版本
    $ sudo snap install pycharm-professional --classic

    2、Community 版本
    $ sudo snap install pycharm-community --classic

### 6、百度云盘
    $ sudo apt install ./baidunetdisk_4.17.7_amd64.deb
    
    登陆账号
    
### 7、安装docker
    
    参考 04_docker.md

### 8、deepin-wine 环境配置

    首次使用需要添加仓库:
    $ wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
    $ sudo apt install ... (安装对应软件包 deepin.com.wechat 微信)
    注意: 应用图标需要注销重登录后才会出现

    参考:
    https://deepin-wine.i-m.dev/ (软件列表)
    https://ubuntukylin.com/applications/
    https://www.cnblogs.com/xlpc/p/12337631.html


### 配置 OneDrive

    $ sudo apt install onedrive -y
    At first run, it asks you to authenticate with a link. 

    之后设置守护进程
    $ systemctl --user enable onedrive
    $ systemctl --user start onedrive


## Ubuntu开机无法进入桌面
    $ sudo vi /etc/default/grub GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"

    $ sudo update-grub2

    quiet-此选项告诉内核不产生任何输出（也称为非详细模式）。如果不使用该选项进行引导，则会看到许多内核消息，例如驱动程序/模块激活，文件系统检查和错误。quiet当您需要查找错误时，没有参数可能很有用。

    splash-当系统的所有核心部分都在后台加载时，此选项用于启动一个令人眼花dy乱的“加载”屏幕。如果禁用它并quiet启用，则会出现空白屏幕。

    nomodeset -告诉内核在系统启动并运行之前不要启动视频驱动程序


### 其他工具

  `1` Shutter: 截图 (x11 是个问题需要解决)

    $ sudo apt-get install shutter

    