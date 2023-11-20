

## 权限和分组
### 登录、注销和登录限制
#### 1. 登录

  在使用authenticate进行验证后，如果验证通过了，那么就会返回一个user对象，拿到user对象之后，可以使用django.contrib.auth.login进行登录，部分示例代码如下:

    user = authenticate(username=username, password=password)
    if user is not None and user.is_active:
        login(request, user)

#### 2. 注销

  注销、或者是退出登录，我们可以通过django.contrib.auth.logout来实现，它会调用flush()方法清除掉用户的session数据。部分示例代码如下:

    from django.contrib.auth import logout

    def logout_view(request):
        logout(request)
        return HttpResponse('Success!')

#### 3. 登录限制

  有时间，某个视图函数是需要经过登录才能访问的，那么我们就可以通过django.contrib.auth.decorators.login_required装饰器实现。示例代码如下:

    from django.contrib.auth.decorators import login_required

    <!--可以指定登录的url-->
    @login_required(login_url='/login_logout/')
    def profile(request):
        return HttpResponse('个人中心！')

#### 4. 参考信息

    166.登录、退出登录以及登录限制案例 
    https://www.cnblogs.com/guyan-2020/p/12350008.html


## 权限-添加权限的两种方式 

  Django 中内置了权限功能，他的权限都是针对表与模型级别的，比如对某个模型上的数据是否可以进行增删改查操作，它不能针对数据级别，比如针对某个表的某条数据进行增删改查操作如果要实现数据级别的，考虑使用 django.guardian.

### 1. 通过定义模型的方式添加权限
  1.1 权限都是django.contrib.auth.Permission的实例。
  这个模型包含三个字段: name、codename、content_type
  其中的 content_type 表示这个permission是属于哪个app下的哪个models。
  1.2 使用Django创建模型，在映射到数据库中之后，就会默认的为项目创建 auth_permission 表，
  表中的字段: name(权限的描述信息); 
  content_type_id（django_content_type表中的key，即代表的是app对应的模型; 
  codename（权限的名字）。
  在我们创建模型的时候，Django默认会为我们添加增（add）、删（delete）、改（change）、查（view）权限，如果想要对某个表或者是模型添加权限。那么，我们可以在定义模型的时候，在Meta类中指定permission。
  
  示例代码如下：
    class Article(models.Model):
        title = models.CharField(max_length=100)
        content = models.CharField(max_length=100)
        author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)

        class Meta:
            permissions = {
                ('black_article', '拉黑文章')
                }
  
  在views.py文件中为user添加该权限。分析: 如果想要为用户添加拉黑文章的权限，那么就需要使用ContentType和Permission模型创建实例对象，首先需要导入Django内置的这两个模型。示例代码如下：

    from django.contrib.auth.models import Permission, ContentType

    def permission_view(request):
        # 1. 通过ContentType模型获取要添加的某个app下的某个模型
        content_type = ContentType.objects.get_for_model(Article)
        # 2. 创建权限示例
        permission = Permission.objects.create(content_type=content_type)
        if permission:
            print('添加权限成功！')
        else:
            print('您不能添加该权限！')
        return HttpResponse('添加权限！')

  之后，就可以在auth_permission中查看到我们添加的拉黑文章的权限了。

### 2. 通过代码的形式

    def permission_view(request):
        # 2. 通过代码的形式添加权限
        content_type = ContentType.objects.get_for_model(Article)
        Permission.objects.create(codename='black_article', name='拉黑文章', content_type=content_type)
        return HttpResponse('添加权限！')

#### 3. 参考信息

    167.权限-添加权限的两种方式 
    https://www.cnblogs.com/guyan-2020/p/12354534.html



## 权限-用户权限和权限相关操作
### 1、set()

  一次性的为用户添加多个权限，权限可以放在一个列表中。

    def user_permission(request):
        # 获取当前数据库中第一为user用户
        user = User.objects.get(pk=1)

        # 首先获取当前app下的User模型在django_content_type表中的信息
        content_type = ContentType.objects.get_for_model(User)
        # 根据content_type查看当前的app下的User表的权限
        permissions = Permission.objects.filter(content_type=content_type)
        for permission in permissions:
            print(permission)

    # 1. 为用户user添加多个权限（一次性添加一个权限列表）使用set()
    user.user_permissions.set(permissions)


### 2、add() 为用户 user 添加权限

    2.1 为用户user添加某个权限，必须是一个个的权限
    user.user_permissions.add(permissions[0], permissions[1])

    2.2 add()函数中可以是列表，即在列表前面有一个“*”，示例代码如下:
    user.user_permissions.add(*permissions)

### 3、clear() 将user上的所有权限一次性全部删除

    user.user_permissions.clear()

### 4、remove()
  将user表中用户的权限一个一个的删除。示例代码如下：

    def user_permission(request):
        # 获取当前数据库中第一为user用户
        user = User.objects.get(pk=1)

        # 首先获取当前app下的User模型在django_content_type表中的信息
        content_type = ContentType.objects.get_for_model(User)
        # 根据content_type查看当前的app下的User表的权限
        permissions = Permission.objects.filter(content_type=content_type)
        for permission in permissions:
            print(permission)

    # remove()删除user表上的用户权限，一个一个的删除
    user.user_permissions.remove(permissions[0])
    return HttpResponse('为User模型中的某个用户添加一定的权限！')

    remove()函数中如果传入列表的的话，一定要在列表前面加上“*”，将列表打散。示例代码如下：
    def user_permission(request):
        # 获取当前数据库中第一为user用户
        user = User.objects.get(pk=1)

        # 首先获取当前app下的User模型在django_content_type表中的信息
        content_type = ContentType.objects.get_for_model(User)
        # 根据content_type查看当前的app下的User表的权限
        permissions = Permission.objects.filter(content_type=content_type)
        for permission in permissions:
            print(permission)
        user.user_permissions.remove(*permissions)
        return HttpResponse('为User模型中的某个用户添加一定的权限！')

### 5、has_perm()函数 判断用户是否有这个权限
  判断用户是否有这个权限，只能传入一个权限,进行判断，权限的格式就是"appname.codename"。而has_perms()可以判断一个权限的列表。示例代码如下:

    user = User.objects.get(pk=1)
    if user.has_perm('login_logout.add_user'):
        print("您拥有该权限！")
    else:
        print("您没有该权限！")

### 6、get_all_permissions() 获得所有的权限
    
    user = User.objects.get(pk=1)
    permissions = user.get_all_permissions()

#### 7. 参考信息

    168.权限-用户权限和权限相关操作
    https://www.cnblogs.com/guyan-2020/p/12354548.html


## 权限-权限验证装饰器

  1. 使用 django.contrib.auth.decorators.permission_required 可以非常方便的检查用户是否拥有这个权限，如果有，那么久可以进入到指定的视图中，如果不拥有，那么就会报一个400的错误。
  2. 在用户访问 article 表之前，判断用户是否登录，并且有访问article 表的权限。

  判断用户是否登录就可以使用到user对象的is_authenticated方法，如果为True，就认为是已经登录了。用户登录了之后就需要判断用户是否拥有查看 article 表的权限，可以通过has_perm()方法实现，示例代码如下:

    def login_permission(request):
        # 首先需要先判断用户是否登录
        user = User.objects.get(pk=1)
        if user.is_authenticated:
            if user.has_perm('login_logout.view_article'):
                print("您拥有这个权限！")
            else:
                print('您没有这个权限！')
        else:
            print("您还没有登录")
            return redirect(reverse('login_logout:login'))
        return HttpResponse('登录验证！')

  其实，在 Django 中内置了一个和 login_required（验证用户只有在登录了之后才能访问某些页面的装饰器）作用相似的装饰器permission_required（验证用户只有拥有某些权限才能访问某些页面）。示例代码如下:

    @permission_required('login_logout.view_user')
    def login_permission(request):
        return HttpResponse('登录验证！')

  此时，如果没有登录，就去访问我们的 login_permission 页面，就会出现404的界面，原因就是我们的 Django 会跳转到内置的登录url，但是，在我们的urls.py文件中，又没有定义该url，所以就会出现404的界面。解决的办法就是，在permission_required('login_logout.view_user')中添加一个login_url，

    @permission_required('login_logout.view_user', login_url='/login_logout/')

  在没有登录的情况下，输入url：http://127.0.0.1:8000/login_logout/login_permission/， 就会自动跳转到：http://127.0.0.1:8000/login_logout/?next=/login_logout/login_permission/。 登录成功之后，就可以跳转到login_permission界面。并且我们可以设置raise_exception=True,如果设置了该参数并且在项目中写了403的模板，出现403（没有权限访问某些页面的时候就会返回给用户403的模板）

#### 7. 参考信息

    169.权限-权限验证装饰器
    https://www.cnblogs.com/guyan-2020/p/12354555.html