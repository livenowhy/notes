## 基本概念
  
  1、在一个新的项目根目录下执行 pipenv install，则他会自动创建一个虚拟环境，并且生成一个Pipfile文件;
  2、当 install 命令没有传递参数指定安装包，如果当前存在Pipfile，则会自动安装所有Pipfile中的[packages]中的包


### 创建pipenv虚拟环境
    
    1、创建项目目录
    $ mkdir project1
    $ cd project1
    
    2、可以指定Python版本来创建虚拟环境 (可以省了 使用版本的 python)
    $ pipenv --python 3.10.4
    
    # 由于项目是新建的，所以会自动生成Pipfile和Pipfile.lock文件
    $ pipenv install
    
    # 不进入虚拟环境执行命令,默认只有以下这几个包，和用virtualenv中时一样的
    $ pipenv run pip list
    Package    Version
    ---------- -------
    pip        21.3.1
    setuptools 59.6.0
    wheel      0.37.1

### 相关命令
    
    1、激活虚拟环境
    $ pipenv shell
    
    2、安装包
    $ pipenv install requests
    
    3、查看包的依赖关系
    $ pipenv graph
    
    4、升级某一个包
    $ pipenv update requests
    
    5、退出虚拟环境
    $ exit
    
    6、删除虚拟环境。删除虚拟环境不会删除项目目录，只是删除虚拟环境的目录
    $ pipenv --rm