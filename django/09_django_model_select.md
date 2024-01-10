# Django model select的各种用法详解

## 基本操作

    # 获取所有数据,对应SQL:
    select * from User
    User.objects.all()

    # 匹配, 对应SQL: 
    select * from User where name = '运维咖啡吧'
    User.objects.filter(name='运维咖啡吧')

    # 不匹配, 对应SQL:
    select * from User where name != '运维咖啡吧'
    User.objects.exclude(name='运维咖啡吧')

    # 获取单条数据(有且仅有一条，id唯一),对应SQL:
    select * from User where id = 724
    User.objects.get(id=123)


## 常用操作

    # 获取总数,对应SQL:
    select count(1) from User
    User.objects.count()
    User.objects.filter(name='运维咖啡吧').count()

    # 比较,gt:>, gte:>=, lt:<, lte:<=, 对应SQL:
    select * from User where id > 724
    User.objects.filter(id__gt=724)
    User.objects.filter(id__gt=1, id__lt=10)

    # 包含, in, 对应SQL:
    select * from User where id in (11,22,33)
    User.objects.filter(id__in=[11, 22, 33])
    User.objects.exclude(id__in=[11, 22, 33])

    # isnull: isnull=True为空, isnull=False不为空, 对应SQL:
    select * from User where pub_date is null
    User.objects.filter(pub_date__isnull=True)

    # like, contains 大小写敏感, icontains 大小写不敏感, 相同用法的还有 startswith、endswith
    User.objects.filter(name__contains="sre")
    User.objects.exclude(name__contains="sre")

    # 范围, between and, 对应SQL: 
    select * from User where id between 3 and 8
    User.objects.filter(id__range=[3, 8])

    # 排序, order by, 'id'按id正序, '-id'按id倒叙
    User.objects.filter(name='运维咖啡吧').order_by('id')
    User.objects.filter(name='运维咖啡吧').order_by('-id')

    # 多级排序, order by, 先按name进行正序排列，如果name一致则再按照id倒叙排列
    User.objects.filter(name='运维咖啡吧').order_by('name','-id')


## 进阶操作

    # limit, 对应SQL: 
    select * from User limit 3;
    User.objects.all()[:3]

    # limit, 取第三条以后的数据, 没有对应的SQL, 类似的如:
    select * from User limit 3,10000000;
    从第3条开始取数据，取10000000条（10000000大于表中数据条数）
    User.objects.all()[3:]

    # offset, 取出结果的第 10-20 条数据(不包含10，包含20),也没有对应SQL, 参考上边的SQL写法
    User.objects.all()[10:20]

    # 分组, group by, 对应SQL:
    select username, count(1) from User group by username;
    from django.db.models import Count
    User.objects.values_list('username').annotate(Count('id'))

    # 去重 distinct, 对应SQL:
    select distinct(username) from User
    User.objects.values('username').distinct().count()

    # filter 多列、查询多列,对应SQL:
    select username, fullname from accounts_user
    User.objects.values_list('username', 'fullname')

    # filter单列、查询单列,正常values_list给出的结果是个列表，里边里边的每条数据对应一个元组,当只查询一列时，可以使用flat标签去掉元组,将每条数据的结果以字符串的形式存储在列表中,从而避免解析元组的麻烦
    User.objects.values_list('username', flat=True)

    # int 字段取最大值、最小值、综合、平均数
    from django.db.models import Sum,Count,Max,Min,Avg

    User.objects.aggregate(Count(‘id’))
    User.objects.aggregate(Sum(‘age’))

## 时间字段

    # 匹配日期,date
    User.objects.filter(create_time__date=datetime.date(2018, 8, 1))
    User.objects.filter(create_time__date__gt=datetime.date(2018, 8, 2))

    # 匹配年,year,相同用法的还有匹配月month,匹配日day,匹配周week_day，匹配时hour，匹配分minute，匹配秒second
    User.objects.filter(create_time__year=2018)
    User.objects.filter(create_time__year__gte=2018)

    # 按天统计归档
    today = datetime.date.today()
    select = {'day': connection.ops.date_trunc_sql('day', 'create_time')}
    deploy_date_count = Task.objects.filter(
        create_time__range=(today - datetime.timedelta(days=7), today)
    ).extra(select=select).values('day').annotate(number=Count('id'))


## Q 的使用

  Q对象可以对关键字参数进行封装,从而更好的应用多个查询,可以组合&(and)、|(or)、~(not)操作符.

  例如下边的语句

    from django.db.models import Q

    User.objects.filter(
        Q(role__startswith='sre_'),
        Q(name='公众号') | Q(name='运维咖啡吧')
    )


  转换成SQL语句如下:

    select * from User where role like 'sre_%' and (name='公众号' or name='运维咖啡吧')

  通常更多的时候我们用Q来做搜索逻辑，比如前台搜索框输入一个字符，后台去数据库中检索标题或内容中是否包含

    _s = request.GET.get('search')

    _t = Blog.objects.all()
    if _s:
        _t = _t.filter(
            Q(title__icontains=_s) |
            Q(content__icontains=_s)
        )

    return _t

## 外键:ForeignKey

  表结构:

    class Role(models.Model):
        name = models.CharField(max_length=16, unique=True)


    class User(models.Model):
        username = models.EmailField(max_length=255, unique=True)
        role = models.ForeignKey(Role, on_delete=models.CASCADE)

  正向查询:

    # 查询用户的角色名
    _t = User.objects.get(username='运维咖啡吧')
    _t.role.name

  反向查询:

    # 查询角色下包含的所有用户
    _t = Role.objects.get(name='Role03')
    _t.user_set.all()

  另一种反向查询的方法：
    
    _t = Role.objects.get(name='Role03')

    # 这种方法比上一种_set的方法查询速度要快
    User.objects.filter(role=_t)

  第三种反向查询的方法:
  如果外键字段有related_name属性，例如models如下:

    class User(models.Model):
        username = models.EmailField(max_length=255, unique=True)
        role = models.ForeignKey(Role, on_delete=models.CASCADE,related_name='roleUsers')

  那么可以直接用 related_name 属性取到某角色的所有用户

    _t = Role.objects.get(name = 'Role03')
    _t.roleUsers.all()

## M2M: ManyToManyField

  表结构:

    class Group(models.Model):
        name = models.CharField(max_length=16, unique=True)

    class User(models.Model):
        username = models.CharField(max_length=255, unique=True)
        groups = models.ManyToManyField(Group, related_name='groupUsers')

  正向查询:

    # 查询用户隶属组
    _t = User.objects.get(username = '运维咖啡吧')
    _t.groups.all()

  反向查询:

    # 查询组包含用户
    _t = Group.objects.get(name = 'groupC')
    _t.user_set.all()

  同样 M2M 字段如果有 related_name 属性，那么可以直接用下边的方式反查

    _t = Group.objects.get(name = 'groupC')
    _t.groupUsers.all()

## get_object_or_404

  正常如果我们要去数据库里搜索某一条数据时，通常使用下边的方法：

    _t = User.objects.get(id=734)
  
  但当id=724的数据不存在时，程序将会抛出一个错误

    abcer.models.DoesNotExist: User matching query does not exist.

  为了程序兼容和异常判断，我们可以使用下边两种方式:

  方式一: get改为filter

    _t = User.objects.filter(id=724)
    # 取出_t之后再去判断_t是否存在

  方式二: 使用get_object_or_404

    from django.shortcuts import get_object_or_404

    _t = get_object_or_404(User, id=724)
    # get_object_or_404方法，它会先调用django的get方法，如果查询的对象不存在的话，则抛出一个Http404的异常

  实现方法类似于下边这样：

    from django.http import Http404

    try:
        _t = User.objects.get(id=724)
    except User.DoesNotExist:
        raise Http404

## get_or_create

  顾名思义，查找一个对象如果不存在则创建，如下:

    object, created = User.objects.get_or_create(username='运维咖啡吧')

  返回一个由 object 和 created 组成的元组，其中 object 就是一个查询到的或者是被创建的对象，created是一个表示是否创建了新对象的布尔值

  实现方式类似于下边这样:

    try:
        object = User.objects.get(username='运维咖啡吧')
        created = False
    exception User.DoesNoExist:
        object = User(username='运维咖啡吧')
        object.save()

        created = True

    returen object, created

## 执行原生SQL

  Django中能用ORM的就用它ORM吧，不建议执行原生SQL，可能会有一些安全问题，如果实在是SQL太复杂ORM实现不了，那就看看下边执行原生SQL的方法，跟直接使用pymysql基本一致了

    from django.db import connection

    with connection.cursor() as cursor:
        cursor.execute('select * from accounts_User')
        row = cursor.fetchall()

    return row
    注意这里表名字要用 app 名+下划线+model名的方式
