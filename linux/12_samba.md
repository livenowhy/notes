## samba 服务


    yum -y install samba
    cd /etc/samba
    vim smb.conf


        [global]
            workgroup = SAMBA
            security = user

            passdb backend = tdbsam

            printing = cups
            printcap name = cups
            load printers = yes
            cups options = raw

        [share]
            comment = sbm
            path = /share
            writable = yes
            guest ok = no
            valid users = @centos