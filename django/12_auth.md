## Django权限系统auth模块详解
  
  auth 模块是 Django 提供的标准权限管理系统, 可以提供用户身份认证, 用户组和权限管理。
  auth 可以和 admin 模块配合使用，快速建立网站的管理系统。
  在 INSTALLED_APPS 中添加 'django.contrib.auth' 使用该APP, auth模块默认启用。

## User
    
    User 是 auth 模块中维护用户信息的关系模式(继承了models.Model), 数据库中该表被命名为auth_user.

    AUTH_USER_MODEL = "sql.Users"
    
    User表的SQL描述:

    CREATE TABLE "auth_user" (
        "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
        "password" varchar(128) NOT NULL, "last_login" datetime NULL, 
        "is_superuser" bool NOT NULL, 
        "first_name" varchar(30) NOT NULL, 
        "last_name" varchar(30) NOT NULL,
        "email" varchar(254) NOT NULL, 
        "is_staff" bool NOT NULL, 
        "is_active" bool NOT NULL,
        "date_joined" datetime NOT NULL,
        "username" varchar(30) NOT NULL UNIQUE
    )

  auth模块提供了很多 API 管理用户信息, 在必要的时候我们可以导入User表进行操作, 比如其它表需要与User建立关联时:

    from django.contrib.auth.models import User

  创建用户:

    user = User.objects.create_user(username, email, password)

  建立user对象:

    user.save()

  在此，需要调用 save() 方法才可将此新用户保存到数据库中。

    auth 模块不存储用户密码明文而是存储一个Hash值, 比如迭代使用Md5算法.

## 认证用户

  使用 authenticate 模块，使用时先导入模块:

    from django.contrib.auth import authenticate

  使用关键字参数传递账户和凭据:

    user = authenticate(username=username, password=password)
  
  认证用户的密码是否有效, 若有效则返回代表该用户的user对象, 若无效则返回None。

  需要注意的是:该方法不检查 is_active 标志位。

## 修改用户密码

  修改密码是 User 的实例方法, 该方法不验证用户身份:

    user.set_password(new_password)

  通常该方法需要和 authenticate 配合使用:

    user = auth.authenticate(username=username, password=old_password)
    if user is not None:
        user.set_password(new_password)
        user.save()

## 登录
  
  先导入模块:

    from django.contrib.auth import login

  login 向 session 中添加 SESSION_KEY, 便于对用户进行跟踪:

    login(request, user)
  
  login不进行认证,也不检查is_active标志位, 一般和authenticate配合使用:

    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            login(request, user)
  
  在 auth/__init__.py 中可以看到 login 的源代码。

## 退出登录
  logout 会移除 request 中的 user 信息, 并刷新session:

    from django.contrib.auth import logout

    def logout_view(request):
        logout(request)

## 权限判断，只允许登录用户访问

  @login_required 修饰器修饰的 view 函数会先通过 session key 检查是否登录, 已登录用户可以正常的执行操作, 未登录用户将被重定向到 login_url 指定的位置。若未指定 login_url 参数, 则重定向到 settings.LOGIN_URL。

    from django.contrib.auth.decorators import login_required

    @login_required(login_url='/accounts/login/')
    def my_view(request):
        ...

## Group

  django.contrib.auth.models.Group 定义了用户组的模型， 每个用户组拥有id和name两个字段, 该模型在数据库被映射为 auth_group 数据表。

  User 对象中有一个名为 groups 的多对多字段, 多对多关系由 auth_user_groups 数据表维护。Group 对象可以通过 user_set 反向查询用户组中的用户。

  我们可以通过创建删除 Group 对象来添加或删除用户组:

    # add
    group = Group.objects.create(name=group_name)
    group.save()
    # del
    group.delete()

  我们可以通过标准的多对多字段操作管理用户与用户组的关系:

    #用户加入用户组
    user.groups.add(group)
    #或者
    group.user_set.add(user)

    #用户退出用户组
    user.groups.remove(group)
    #或者
    group.user_set.remove(user)

    #用户退出所有用户组
    user.groups.clear()

    #用户组中所有用户退出组
    group.user_set.clear()

## Permission

  Django 的 auth 系统提供了模型级的权限控制,即可以检查用户是否对某个数据表拥有增(add), 改(change), 删(delete)权限。

  auth 系统无法提供对象级的权限控制, 即检查用户是否对数据表中某条记录拥有增改删的权限。如果需要对象级权限控制可以使用django-guardian。

  假设在博客系统中有一张 article 数据表管理博文, auth可以检查某个用户是否拥有对所有博文的管理权限, 但无法检查用户对某一篇博文是否拥有管理权限。

## 检查用户权限
  
  user.has_perm 方法用于检查用户是否拥有操作某个模型的权限:

    user.has_perm('blog.add_article')
    user.has_perm('blog.change_article')
    user.has_perm('blog.delete_article')

  上述语句检查用户是否拥有blog这个app中article模型的添加权限， 若拥有权限则返回True。

  has_perm 仅是进行权限检查, 即是用户没有权限它也不会阻止程序员执行相关操作。

  @permission_required 装饰器可以代替 has_perm 并在用户没有相应权限时重定向到登录页或者抛出异常。

    # permission_required(perm[, login_url=None, raise_exception=False])

    @permission_required('blog.add_article')
    def post_article(request):
        pass

  每个模型默认拥有增(add), 改(change), 删(delete)权限。
  在 django.contrib.auth.models.Permission 模型中保存了项目中所有权限。

  该模型在数据库中被保存为 auth_permission 数据表。每条权限拥有id, name, content_type_id, codename四个字段。

## 管理用户权限

  User 和 Permission 通过多对多字段user.user_permissions关联，在数据库中由auth_user_user_permissions数据表维护。

    #添加权限
    user.user_permissions.add(permission)

    #删除权限: 
    user.user_permissions.delete(permission)

    #清空权限: 
    user.user_permissions.clear()

  用户拥有他所在用户组的权限，使用用户组管理权限是一个更方便的方法。Group中包含多对多字段 permissions，在数据库中由 auth_group_permissions 数据表维护。

    #添加权限: 
    group.permissions.add(permission)

    #删除权限: 
    group.permissions.delete(permission)

    #清空权限: 
    group.permissions.clear()

## 自定义权限
  在定义Model时可以使用Meta自定义权限：

    class Discussion(models.Model):
        ...
        class Meta:
            permissions = (
                ("create_discussion", "Can create a discussion"),
                ("reply_discussion", "Can reply discussion"),
            )

  判断用户是否拥有自定义权限:

    user.has_perm('blog.create_discussion')
