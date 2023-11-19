## 方法一: 直接发布静态文件到 Github Pages

## 方法二: 使用单独的项目的 Github Pages 功能

### 1 用项目的 Pages 服务

    1、新建仓库与分支
    在 github 创建一个仓库, 命名 notes

    2、克隆仓库到本地
    $ git clone git@github.com:/USER_NAME/notes.git
    $ cd notes
    $ 添加一个文件 (.gitignore)，否则第 3 步无法执行
    $ ...
    $ git push origin master

    3、创建一个新分支
    $ git checkout -b gh-pages (注意: 分支名必须为gh-pages)

    4、将分支push到仓库
    $ git push -u origin gh-pages
    
    经过这一步处理，我们已经创建了gh-pages分支了, 有了这个分支, Github会自动为你分配一个网址:
    http://USERNAME.github.io/notes

    5、切换到主分支
    $ git checkout master

    此时 master 和 gh-pages 分支下都是空白的

    6、添加日记和忽略

### 2 同步静态网站代码到分支

    1、build 静态代码
    $ docker run -it --volume /share/notes:/notes registry.cn-beijing.aliyuncs.com/livenowhy/node:gitbook bash
    $ gitbook build .

    2、克隆gh-pages分支 (这步我们只是克隆了gh-pages分支, 并存放在一个新的目录notes-end)
    $ git clone -b gh-pages git@github.com:USER_NAME/notes.git notes-end

    3、copy 静态网站到 notes-end 目录中
    $ cp  -r ../notes/_book/* .

    4、Push gh-pages分支到仓库
    然后，等几分钟后，就可以访问到在线图书了。以后，只要你每次修改之后，将生成静态网站 copy 到 notes-end目录，然后 Push一下就OK了。

    5、特别说明
    master 存放源文件; gh-pages 存放静态文件
