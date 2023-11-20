# python django 模型内部类 meta 详细解释

## Django 模型类的 Meta 是一个内部类，它用于定义一些 Django 模型类的行为特性

### 自定义字段类型

  模型元数据是"任何不是字段的数据"
  比如排序选项(ordering)
  数据库表名(db_table)
  类可读的单复数名称(verbose_name和verbose_name_plural)
  在模型中添加 class Meta 是完全可选的，所有选项都不是必须的。

### abstract

    这个属性是定义当前的模型类是不是一个抽象类。
    所谓抽象类是不会相应数据库表的。一般我们用它来归纳一些公共属性字段，然后继承它的子类能够继承这些字段。
    比方以下的代码中 Human 是一个抽象类。Employee 是一个继承了 Human 的子类，那么在执行 syncdb 命令时，不会生成Human表。
    可是会生成一个 Employee 表，它包括了 Human 中继承来的字段。以后假设再加入一个 Customer 模型类，它能够相同继承 Human 的公共属性：

    class Human(models.Model):
        name=models.CharField(max_length=100)
        GENDER_CHOICE=((u'M',u'Male'),(u'F',u'Female'),)
        gender=models.CharField(max_length=2,choices=GENDER_CHOICE,null=True)

        class Meta:
            abstract=True

    class Employee(Human):
        joint_date=models.DateField()

    class Customer(Human):
        first_name=models.CharField(max_length=100)
        birth_day=models.DateField()

### app_label

    app_label这个选项仅仅在一种情况下使用，就是你的模型类不在默认的应用程序包下的 models.py 文件里。
    这时候你须要指定你这个模型类是那个应用程序的。比方你在其它地方写了一个模型类，而这个模型类是属于 userapp 的，那么你这是须要指定为: app_label='userapp'

### db_table

    db_table是用于指定自己定义数据库表名的。
    Django有一套默认的依照一定规则生成数据模型相应的数据库表名。假设你想使用自己定义的表名。就通过这个属性指定，比方: table_name='user_table'


### db_tablespace

    有些数据库有数据库表空间，比方Oracle。你能够通过 db_tablespace 来指定这个模型相应的数据库表放在哪个数据库表空间。

### get_latest_by

    因为Django的管理方法中有个 lastest() 方法，就是得到近期一行记录。
    假设你的数据模型中有 DateField 或 DateTimeField 类型的字段。你能够通过这个选项来指定 lastest() 是依照哪个字段进行选取的。

### managed

    因为 Django 会自己主动依据模型类生成映射的数据库表。假设你不希望Django这么做。能够把managed的值设置为False。

### order_with_respect_to

    这个选项一般用于多对多的关系中，它指向一个关联对象。就是说关联对象找到这个对象后它是经过排序的。
    指定这个属性后你会得到一个get_XXX_order()和set_XXX_order（）的方法,通过它们你能够设置或者回去排序的对象。

### ordering

    这个字段是告诉Django模型对象返回的记录结果集是依照哪个字段排序的。比方以下的代码:

    ordering=['order_date'] # 按订单升序排列
    ordering=['-order_date'] # 按订单降序排列，-表示降序
    ordering=['?order_date'] # 随机排序。？表示随机

### permissions

    permissions主要是为了在Django Admin管理模块下使用的。假设你设置了这个属性能够让指定的方法权限描写叙述更清晰可读。


### unique_together

    unique_together这个选项用于: 当你须要通过两个字段保持唯一性时使用。
    比方如果你希望，一个Person的FirstName和LastName两者的组合必须是唯一的，那么须要这样设置：
    unique_together = (("first_name", "last_name"),)

### verbose_name

    verbose_name的意思非常easy。就是给你的模型类起一个更可读的名字：
    verbose_name = "pizza"
    verbose_name_plural
    这个选项是指定。模型的复数形式是什么。比方：

    verbose_name_plural = "stories"
    假设你不指定 Django 在型号名称加一后，自己主动’s’
    
### Django 的 order_by 查询集, 升序和降序
    
    Publisher.objects.order_by("state_province", "address")
    Publisher.objects.order_by("-name")     # 指定逆向排序，在前面加一个减号 - 前缀:

### django orm 比较运算

    filter表示 =
    exclude表示 != 
    querySet.distinct() 去重复

    __exact       精确等于 like 'aaa'
    __iexact      精确等于,忽略大小写 ilike 'aaa'
    __contains    包含 like '%aaa%'
    __icontains   包含 忽略大小写 ilike '%aaa%'. 但是对于sqlite来说，contains的作用效果等同于icontains。

    __gt    大于
    __gte   大于等于
    __lt    小于
    __lte   小于等于
    __in    存在于一个 list 范围内
    __startswith    以...开头
    __istartswith   以...开头 忽略大小写
    __endswith      以...结尾
    __iendswith     以...结尾，忽略大小写
    __range         在...范围内
    __year          日期字段的年份
    __month         日期字段的月份
    __day           日期字段的日
    __isnull=True/False


### model常用字段定义

    V = models.CharField(max_length=None[, **options])　　　　# varchar
    V = models.EmailField([max_length=75, **options])　　　　 # varchar
    V = models.URLField([verify_exists=True, max_length=200, **options])　　　　# varchar
    V = models.FileField(upload_to=None[, max_length=100, **options])　　　　   # varchar
    
    # upload_to 指定保存目录可带格式，
    V = models.ImageField(upload_to=None[, height_field=None, width_field=None, max_length=100, **options])

    V = models.IPAddressField([**options])　　　　# varchar
    V = models.FilePathField(path=None[, match=None, recursive=False, max_length=100, **options])　                                # varchar
    V = models.SlugField([max_length=50, **options])　　　　# varchar, 标签，内含索引
    V = models.CommaSeparatedIntegerField(max_length=None[, **options])　　　　#varchar
    V = models.IntegerField([**options])　　　　         # int
    V = models.PositiveIntegerField([**options])　　　　 # int 正整数
    V = models.SmallIntegerField([**options])　　　　    # smallint
    V = models.PositiveSmallIntegerField([**options])　 # smallint 正整数
    V = models.AutoField(**options)　　　　              # int 在 Django 代码内是自增
    V = models.DecimalField(max_digits=None, decimal_places=None[, **options])　# decimal
    V = models.FloatField([**options])　　　　      # real
    V = models.BooleanField(**options)　　　　      # boolean或bit
    V = models.NullBooleanField([**options])　　　　# bit字段上可以设置上null值

    # date auto_now 最后修改记录的日期; auto_now_add 添加记录的日期
    V = models.DateField([auto_now=False, auto_now_add=False, **options])
    V = models.DateTimeField([auto_now=False, auto_now_add=False, **options])　　# datetime
    V = models.TimeField([auto_now=False, auto_now_add=False, **options])　　　　 # time
    V = models.TextField([**options])　　　　                                     # text
    V = models.XMLField(schema_path=None[, **options])   　　                    # text
    V = models.ForeignKey(othermodel[, **options])　　　　  # 外键，关联其它模型，创建关联索引
    V = models.ManyToManyField(othermodel[, **options])　  # 多对多，关联其它模型，创建关联表
    V = models.OneToOneField(othermodel[, parent_link=False, **options])

###

https://www.cnblogs.com/skyflask/p/9349706.html