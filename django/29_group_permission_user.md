## 分组-group、permission、user 的操作

### 分组

    1.Group.objects.create(group_name):创建分组

    2.group.permissions:某个分组上的权限。多对多关系。
    2.1 group.permissions.add(): 添加权限
    2.2 group.permissions.remove(): 删除权限
    2.3 group.permissions.clear(): 清除所有权限
    3.4 user.get_group_permissions(): 获取用户所属组的权限

    3.user.groups 某个用户上的所有权限, 多对多关系。

  因为使用权限常用的相关操作，比如 user.user_permissions.set(),user.user_permission.add(),或者是user.user.permissions.remove()等操作为每一个用户分别添加权限的话，就会比较麻烦。所以我们就可以根据各个职位权限的不同进行分组，并且为用户组进行添加权限。之后将用户添加到分组中就会拥有相应的组的权限了。如果我们还想为某些分组中的用户赋予一些组内其他用户不能有的权限时，就可以使用用户权限的相关操作分别为用户添加权限了。

1. 创建分组，为分组赋予权限，示例代码如下：

def operate_permission(request):
    # 创建一个组
    group = Group.objects.create(name='管理组')
    <!--获取 Article 模型对应的表-->
    content_type = ContentType.objects.get_for_model(Article)
    <!--获取 article 表的用户对应的权限-->
    permissions = Permission.objects.filter(content_type=content_type)
    for permission in permissions:
        print(permission)
    # group.permissions.set(permissions)
    <!--为用户组添加权限使用add()函数，需要注意的是，add()函数中必须传递一个个的权限，不能传递一个权限的列表-->
    group.permissions.add(*permissions)
    # group.save()
    return HttpResponse('操作分组group: 创建分组，并且赋予权限！')

执行完成该操作之后，就可以在auth_group、auth_group_permissions表中看到我们添加的用户分组，并且为相应的分组添加的权限了。

2. 将user表中的第一个用户添加到分组中，示例代码如下：
def operate_permission(request):
    # 2. 将user表中的第一个用户添加到管理分组中
    user = User.objects.first()
    group = Group.objects.filter(name='管理组').first()
    # 将用户添加到分组中
    user.groups.add(group)
    # user.save()
    return HttpResponse('操作分组group: 创建分组，并且赋予权限！')
执行完该操作之后，就可以在user_groups中找到添加的用户及分组了。

3. get_all_permissions()获取用户拥有的所有权限。示例代码如下：
def operate_permisssion(request):
    # 3.可以通过get_all_permissions()获取用户拥有的所有权限
    user = User.objects.first()
    permissions = user.get_all_permissions()
    for permission in permissions:
        print(permission)
    return HttpResponse('操作分组group: 创建分组，并且赋予权限！')
此时就可以在pycharm中的运行窗口，看到打印出的用户权限了。
login_logout.delete_article
login_logout.view_article
login_logout.change_article
login_logout.add_article
login_logout.black_article
如果你之前通过user.user_permissions.set()等操作已经为用户user赋予过权限的话，在user_permissions表中会有相应的对应关系。但是，需要注意的是，我们此时打印出的并不是通过具体的用户权限的操作为user添加的权限，而是通过查找我们的user属于哪个分组，分组又有什么样的权限，那么该user就有什么样的权限。可以将该用户在user_permissions表中对应的权限相关关系删除，之后再次运行项目，同样可以打印出user拥有的权限，此时，就可以去确定该user的权限来自分组对应的权限。
4. 可以通过has_perm()判断用户是否有该权限，示例代码如下：
def operate_permission(request):
    # 4.通过has_perm()判断用户
    user = User.objects.first()
    if user.has_perm('login_logout.add_article'):
        print("您拥有该权限")
    else:
        print("不好意思，您没有权限")
    return HttpResponse('操作分组group: 创建分组，并且赋予权限！')
5. 同样判断用户是否登录还可以使用permissions_required装饰器判断，示例代码如下：
@permission_required(['login_logout.view_user','login_logout.add_user'], login_url= '/login_logout/', raise_exception=True)
<!--可以传递一个权限的列表进行判断-->

## 在模板中添加权限控制
  在 settings.TEMPLATES.OPTIONS.context_process 下，因为添加了 django.auth.context_processors.auth 上下文处理器，因此，在模板中可以直接通过 perms 来获取用户的所有权限，示例代码如下:

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>操作权限首页</title>
    </head>
    <body>
    操作权限首页
    {% if perms.login_logout.view_article %}
        <li><a href="#">查看文章</a></li>
    {% endif %}
    </body>
    </html>
  
  可以在模板中将某一个功能模块设置用户必须拥有某些权限才能够访问，这时候用户就必须登录并且拥有这些权限，才能够访问该功能。


## 参考资料

    170.分组-group、permission、user的操作
    分组
    https://www.cnblogs.com/guyan-2020/p/12356184.html

    171.补充-在模板中添加权限控制
    https://www.cnblogs.com/guyan-2020/p/12356192.html