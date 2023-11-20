### Centos安装桌面系统并设置成默认启动

  `1` 安装GNOME桌面环境
    
    $ yum -y groups install "GNOME Desktop"
    
  `2` 启动模式的默认选择：

    $ systemctl set-default multi-user.target   // 设置成命令模式
    $ systemctl set-default graphical.target    // 设置成图形模式
  
  `3` 完成安装后输入如下所示的命令:
  
    $ reboot


### 配置桌面 pycharm
    $ cd /usr/local/
    $ mkdir pycharm   (pycharm.tar.gz 解压文件)


    创建桌面图标: 在终端输入命令
    gedit /usr/share/applications/Pycharm.desktop
    [Desktop Entry]
    Type=Application
    Name=Pycharm
    GenericName=Pycharm3
    Comment=Pycharm3:The Python IDE
    Exec=sh /usr/local/pycharm/bin/pycharm.sh     
    Icon=/usr/local/pycharm/bin/pycharm.png
    Terminal=pycharm
    Categories=Pycharm;
