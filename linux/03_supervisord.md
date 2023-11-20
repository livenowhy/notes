## supervisord 安装及设置

### centos

    $ pip3 install supervisor (yum install -y supervisor)
    $ echo_supervisord_conf > /etc/supervisord.conf
    $ echo '[include]' >> /etc/supervisord.conf
    $ echo 'files = /etc/supervisord.d/*.ini' >> /etc/supervisord.conf
    $ mkdir /etc/supervisord.d/
    $ mkdir /var/log/supervisor/
    $ supervisord -c /etc/supervisord.conf

### ubuntu

    $ apt-get install supervisor -y