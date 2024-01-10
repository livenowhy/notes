## Auth 系统中的表

## auth 系统的数据表

    auth_user: 存放了用户
    auth_group: 用户组
    auth_permission分别: 权限的信息表

    auth_group_permissions、auth_user_groups、auth_user_user_permissions三张表是多对多的关系表


## User 模型常用属性和方法

    groups: 多对多的组
    user_permissions: 多对多的用户权限
    is_staff: 是否是 admin 的管理员(如果没有,后台admin登录不进去)
    is_active: 是否激活,判断该用户是否可用(设置为 False，可以在不删除用户的前提下禁止用户登录)
    is_superuser: 是否是超级用户
    is_authenticated: 是否验证通过了
    is_anonymous: 是否是匿名用户
    set_password(raw_password):设置密码，传原生密码进去
    check_password(raw_password):检查密码
    has_perm(perm):判断用户是否有某个权限
    has_perms(perm_list):判断用户是否有权限列表中的某个列表

## 1. auth介绍
  
  Django 自带一个用户验证系统。它负责处理用户账号、组、权限和基于cookie的用户会话。
  认证系统由以下部分组成:
  1、用户
  2、权限: 二进制(是/否)标识指定用户是否可以执行特定任务。
  3、组: 将标签和权限应用于多个用户的一般方法。
  4、可配置的密码哈希化系统
  5、为登录用户或限制内容提供表单和视图工具
  6、可插拔的后端系统

## 2.auth 常用操作
### 2.1 创建用户
  创建用户使用 User 对象。
  2.1.1 创建普通用户

    >>> from django.contrib.auth.models import User
    >>> user = User.objects.create_user(username='john', email='lennon@thebeatles.com', password='johnpassword')
    >>> user.last_name = 'Lennon'
    >>> user.save()
    # 创建普通用户可以不写email
  
  2.1.2 创建超级用户

    $ python manage.py createsuperuser
    user (leave blank to use 'hans'): test
    Email address:
    Warning: Password input may be echoed.
    Password: 
    
    或:
    python manage.py createsuperuser --username=joe --email=joe@example.com
    然后输入密码
    
    使用代码创建超级用户:
    >>> from django.contrib.auth.models import User
    >>> user = User.objects.create_superuser()('john', 'lennon@thebeatles.com', 'johnpassword')
    >>> user.last_name = 'Lennon'
    >>> user.save()
    # 创建超级用户必须要写email


### 2.2 验证用户
  
  使用 authenticate() 来验证用户，即验证用户名以及密码是否正确。它使用 username 和 password 作为参数来验证，如果后端验证有效，则返回一个 :class:~django.contrib.auth.models.User 对象。如果后端引发 PermissionDenied错误，将返回 None。

    from django.contrib.auth import authenticate
    user = authenticate(username='john', password='secret')
    if user is not None:
        # A backend authenticated the credentials
    else:
        # No backend authenticated the credentials

### 2.3 验证用户是否登录
  使用 request.user.is_authenticated 验证用户是否登录，始终返回 True(匿名用户 AnonymousUser.is_authenticated 始终返回 False )。这是一种判断用户是否已通过身份认证的方法。

    if request.user.is_authenticated:
        # Do something for authenticated users.
        ...
    else:
        # Do something for anonymous users.
        ...
  
  没有用户登录将会被设置为 AnonymousUser 否则设置为登录用户

  在前端模版本中使用:

    {% if request.user.is_authenticated %}
        {{ request.user.username }} 欢迎你
    {% else %}
        <a href="/auth_login/">请去登录</a>
    {% endif %}

### 2.4 已验证的用户想附加到当前会话
  例如登录后想要拿到具体登录的用户。就可以使用 login()

    from django.contrib.auth import login
    login(request, user, backend=None)

### 2.5 快捷增加登录校验装饰器
  auth 给提供的一个装饰器工具，用来快捷的给某个视图添加登录校验。

    from django.contrib.auth.decorators import login_required
    @login_required(url='/login/')  # 如果没有登录，则跳转到login页面
    def my_view(request):

    3.2版本中 @login_required(login_url='/login/')

### 2.6 退出登录
    from django.contrib.auth import logout
    logout(request)

    调用 logout() 后,当前请求的会话数据会被全部清除。这是为了防止其他使用同一个浏览器的用户访问前一名用户的会话数据; 如果用户未登录, logout() 不会报错。

### 2.7 检查密码
    check_password(raw_password)
    如果给定的原始字符串是用户的正确密码，返回 True。(密码哈希值用于比较)

### 2.8 修改密码
    set_password
    注意:设置完一定要调用用户对象的save方法!!!

    另一个方法：
    python manage.py changepassword *username* 


## 3 扩展默认的auth_user表
### 3.1 方案一: 一对一扩展
    from django.contrib.auth.models import User 
    class user_info(models.Model):
        user=models.OneToOneField(to=User)
        phone=models.CharField(max_length=32)  # 增加了phone字段
    
### 3.2 方案二： 继承AbstractUser类扩展
    前提是 auth_user 表没有创建之前操作
	1. 写一个类，继承AbstractUser
    2. 在类中扩写字段(可以重写原来有的字段)
        class MyAuthUser(AbstractUser):
    		phone=models.CharField(max_length=32)
    3. 在配置文件中(settings.py)配置
    	# 引用Django自带的User表，继承使用时需要设置
		AUTH_USER_MODEL = "APP名.自己创建的表名"
        如:
        AUTH_USER_MODEL = "auth01.MyAuthUser"
            
    # 如果auth_user表已经有了，还想扩写需要以下三步:
    -删库
    -清空项目中所有migration的记录
    -清空源码中admin，auth俩app的migration的记录

    https://www.cnblogs.com/hans-python/p/16010742.html
