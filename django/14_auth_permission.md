## django自带的权限管理Permission用法说明

## 前言

  一些公司内部的CMS系统存在某些内容让指定的用户有权限访问，这时候可以用django自带的权限管理进行限制，比较方便。
  
  缺点: django 自带的权限是针对 model（模型）的, 不能针对单条数据, 要针对单条数据需要额外的操作。

    默认的权限(add, change, delete, view)

  django 针对每个模型，生成了四个默认的权限(add, change, delete, view).
  例如，我有一个 model 叫 Log，那么这四个默认权限在数据库的存储格式为:

  表 auth_permission（ 注：id 字段的值是随便取的，使用 python manage.py migrate 的时候会自动生成）


| id |       name      |   content_type_id	|  codename   |
| -- |  :------------: | :----------------: | :----:      |
|1   | Can add log     |      7             |   add_log   |
|2   | Can change log  |      7             |  change_log |
|3   | Can delete log  |      7             | delete_log  |
|4   | Can view log    |      7             |  view_log   |

字段解释
id: 自动生成的
name: 描述权限的的内容，无太大的实际作用
content_type_id: 与 django_content_type 中的 id 字段对应
codename: 权限表示值，换句话说用 add_log 来表示用户对 Log 模型有新增权限。验证权限的时候就是验证这个值

那如果我的模型叫Student呢，把上面表中的log替换成student就行了.
name 字段中 Can add xx，Can change xx 等都是固定的，只有 xx 是根据模型来的。
同理，codename 字段也是一样，add_xxx，change_xxx。

auth_permission表中content_type_id字段还没有解释，先来看下面这张表:
表django_content_type

    id    app_label         model
    1      admin          logentry
    3      auth           group
    2      auth           permission
    4      auth           user
    5      contenttypes   contenttype
    6      sessions       session
    7      test           log

字段解释

id: 自增字段; auth_permission 表的 content_type_id 字段就对应这个值

app_label:属于哪个 app 包，上面的Log就是test app下的模型
model: 模型名字

使用方法,在函数中验证权限，使用user.has_perm

例如：我们有一个书店，有普通员工A（model User），现在需要去出版社订购一批书（model Book），我们判断这个人是否有权利添加（add_book）书籍。

    user = User.objects.get(username='A')
    # has_permission是一个boolean，因为Book模型是放在test app下面的
    has_permission = user.has_perm('test.add_book')

为什么验证权限的时候前面要加 app 名, 很好理解啊，不同app有同样名字的权限，到底是验证哪个呢？
验证函数是否有执行权限，使用 @permission_required

    @permission_required
    def function():
        pass

    permission_required有三个参数
    perm: 描述权限的字符串，格式为: app名.权限。如"auth.add_user"，“auth.delete_user
    login_url: 如果没有权限需要跳转的url字符串，如"/login"，“https://www.baidu.com”
    raise_exception: boolean值，没有权限是否触发 PermissionDenied 异常，触发异常则直接返回，不会跳转到 login_url 指向的地址
