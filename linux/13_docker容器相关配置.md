## docker 容器中设置中文语言包的问题

  `1` 查看系统语言包

    $ locale -a  (会发现没有中文包)
    C
    POSIX
    en_US.utf8

  `2` 解决方案

    $ yum install kde-l10n-Chinese -y 安装语言包(针对centos 7)
    $ yum update
    $ yum upgrade
    
    # 更新gitbc 包(因为该镜像已阉割了该包的部分功能，所以需要更新需要先 update)
    $ yum reinstall glibc-common -y 
    
    $ localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 (设置系统语言包)
    $ LC_ALL=zh_CN.UTF-8

    可以采用直接修改/etc/locale.conf 文件来实现,不过需要reboot
    
  `3` 采用 Dockerfile 的方式
 
    RUN yum install kde-l10n-Chinese -y
    RUN yum install glibc-common -y
    RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
    ENV LC_ALL zh_CN.UTF-8