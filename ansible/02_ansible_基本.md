## ansible 基本操作

### 命令格式

    ansible -i hosts all -m module_name -a args
    -i: 指定主机清单(all 全部)
    -m: 指定调用模块
    -a: 传递给模块的参数

    ansible vm --list-hosts # 列出执行主机列表
    ansible-doc -l                     # 查看所有模块(键入q退出)
    ansible-doc command                # 查看 command 模块详细信息
    ansible-doc -s command             # 查看command模块详细用法
    ansible test -m command -a 'df -h' # 对所有被控服务器使用df -h 命令
    ansible web -m command -a 'useradd Tom'   # 批量添加用户
    
### copy 模块

    $ ansible -i hosts all -m copy -a "src=/Users/zpliu/Desktop/devops/ansible/yum.sh dest=/root/ mode=644 owner=guest group=guest"

### systemd

    $ ansible -i hosts all -m systemd -a "name=nginx enabled=yes state=restarted"

### file

    $ ansible -i hosts all -m file -a "path=/root/tests/ state=directory"