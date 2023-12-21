## git --mirror 概述


    有 A、B 两个 git 仓库，想实现类似主从数据库的效果:

    A 库作为主库提交 Commit 记录
    B 库作为备份库，同步 A 库内容，并在不影响 A 库的情况下提供读取、分析等操作
    
    假设:
    A 库地址为 http://git/repo/source.git
    B 库地址为：http://other/git/sourcemirror.git


    全量镜像，执行一次:
    git clone --mirror http://git/repo/source.git
    cd source.git
    git remote add target http://another/git/sourcemirror.git
    git push --mirror target

    增量同步, 定时执行:
    git --git-dir=/path/to/source.git fetch --prune
    git --git-dir=/path/to/source.git push --mirror target

## 本地镜像

    cd ${mirror_path}
    git checkout ${branch}
    git pull
    git clone --mirror ${repository} ${mirror_path}

    cd  ${workspace}
    git clone --reference ${mirror_path} -b ${branch} --depth=1 ${repository}

    用 Django 做测试
    git clone --mirror git@github.com:django/django.git /root/mirror_path/django
    git clone --reference /root/mirror_path/django -b master --depth=1 git@github.com:django/django.git