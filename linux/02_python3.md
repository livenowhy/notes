### 安装 python3

    安装 pip
    $ wget https://bootstrap.pypa.io/get-pip.py -o /share/get-pip.py
    $ python36 /share/get-pip.py

    安装 virtualenv
    $ pip3 install virtualenv
    $ ln -fs /usr/local/python3/bin/virtualenv /usr/bin/virtualenv
    
    使用 virtualenv
    $ mkdir /penv
    $ cd /penv
    $ virtualenv venv --python=python3
    $ source venv/bin/activate

    基础的依赖
    $ pip3 install mysqlclient
    $ pip3 install pymysql
    $ pip3 install ipython
    
    $ python3 -m pip install mysql-connector (暂时不执行)

## centOS 安装 python3.9.12
    下载python安装包:
    $ wget https://www.python.org/ftp/python/3.9.12/Python-3.9.12.tgz

    $ tar zxvf Python-3.9.12.tgz
    $ cd Python-3.9.12
    
    创建编译安装目录
    $ mkdir /usr/local/python39
    
    配置安装位置
    $ ./configure --prefix=/usr/local/python39

    $ make && make install

    添加环境变量

    $ vim ~/.bash_profile
    PYTHON39=/usr/local/python39
    PATH=$PATH:$HOME/bin:$PYTHON39/bin