## Ubuntu20.04安装搜狗输入法步骤

    参考: https://shurufa.sogou.com/linux/guide
    1、更新源 sudo apt update

    2、安装fcitx输入法框架
    1. 在终端输入 sudo apt install fcitx

    2. 设置 fcitx 为系统输入法

    3. 设置fcitx开机自启动
    $ sudo cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/

    4. 卸载系统 ibus 输入法框架
    $ sudo apt purge ibus

    3、安装搜狗输入法

    1. 在官网下载搜狗输入法安装包，并安装，安装命令 sudo dpkg -i 安装包名

    2. 安装输入法依赖

    $ sudo apt install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 -y
    $ sudo apt install libgsettings-qt1 -y
    4、重启电脑、调出输入法
