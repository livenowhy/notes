## Django--自定义 Command 命令

    Django 对于命令的添加有一套规范，你可以为每个app 指定命令。
    通俗一点讲，比如在使用 manage.py 文件执行命令的时候，可以自定制自己的命令，来实现命令的扩充。

### commands 的创建

    1、在 app 内创建一个 management 的 python 目录
    2、在 management 目录里面创建 commands 的 python 文件夹
    3、在 commands 文件夹下创建任意 py 文件
    
    此时py文件名就是你的自定制命令，可以使用下面方式执行
    $ python manage.py 命令名
    Django 的 Command 命令是要放在一个 app 的 management/commands 目录下的。
    python2 环境中，请确保 management 和 management/commands 目录内都包含 __init__.py 文件
    
    首先对于文件名没什么要求，内部需要定义一个 Command 类并继承 BaseCommand 类或其子类。
    它必须定义一个 Command 类并扩展自 BaseCommand 或其子类。

    其中 help 是 command 功能作用简介，handle 函数是主处理程序，add_arguments 函数是用来接收可选参数的。

    from django.core.management.base import BaseCommand, CommandError
    class Command(BaseCommand):
        help = 'Closes the specified poll for voting'

        def add_arguments(self, parser):
            parser.add_argument('poll_id', nargs='+', type=int)
            parser.add_argument('--delete',
                action='store_true',
                dest='delete',
                default=False,
                help='Delete poll instead of closing it')

        def handle(self, *args, **options):
            print('handlehandle')
            print(args)
            print(options)