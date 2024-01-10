## 提升 jenkins 构建速度

## git 文件过大

### 方法一、压缩 .git 文件体积

  .git 是隐藏文件，该文件夹存储了 Git 仓库的所有元数据和对象，包含：对象数据库（Object Database）、分支和标签信息、配置信息、日志和历史记录、钩子脚本（Hooks）等.
  使用 git 提供的命令行工具将 .git 文件压缩为最小

    $ git gc --aggressive --prune=all

    本机测试一个项目:
    压缩前: 18,905,798 字节（磁盘上的22.8 MB）
    压缩后: 18,814,323 字节（磁盘上的19.6 MB）

### 方法二、使用浅克隆(推荐)

  如果不需要存储库的完整历史记录，并且只对最新的提交和文件更改感兴趣，可以使用Git的浅克隆(shallow clone)功能来减小 .git 文件的大小.只克隆最新提交和文件，而不复制完整的历史记录

    $ git clone --depth 1 -b 分支 仓库地址

    参考文档: http://www.yunweipai.com/43830.html

    验证 github django 源码
    全部 clone 323M; 浅克隆 82M	django

