## ssh 穿越跳板机: 一条命令跨越跳板机直接登陆远程计算机

### 场景说明

    A:本地
    B:跳板机
    C:目标机器
    我们需要登录线上机器时，必须先登录跳板机，再登录目标机器

    |  A  +-----------> |  B  +-----------> |  C  |

    注意: 我们使用了ssh-agent 转发功能，私钥只需要存在A上，B和C都只存放公钥，然后就可以先登录B，再登录C。
    直接编辑~/.ssh/config 文件，增加ProxyCommand选项：

    Host target.machine

        User          targetuser

        HostName      target.machine

        ProxyCommand  ssh proxyuser@proxy.machine nc %h %p 2> /dev/null

        现在，只需要通过下面这样简单的语句登陆远程计算机:
        ssh target.machine
        还可以直接SCP过去，跳板机完全透明:
        scp ToCopy.txt target.machine:~

### 参考资料
    
    注意：~/.ssh/config文件有很多amazing的选项，具体可以参考这里：http://blog.tjll.net/ssh-kung-fu


