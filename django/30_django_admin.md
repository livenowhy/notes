# django-admin基本设置

## 一、基本设置

### 1.1、应用注册

  若要把 app 应用显示在后台管理中，需要在 admin.py 中注册。这个注册有两种方式，我比较喜欢用装饰器的方式。
  1、普通注册方法, admin.py 文件代码如下:

    from django.contrib import admin
    from blog.models import Blog
    
    # Blog 模型的管理器
    class BlogAdmin(admin.ModelAdmin):
        ''' 设置列表可显示的字段 '''
        list_display=('id', 'caption', 'author')
        
    # 在 admin 中注册绑定
    admin.site.register(Blog, BlogAdmin)
    上面方法是将管理器和注册语句分开。有时容易忘记写注册语句，或者模型很多，不容易对应。

  2、装饰器方法:

    from django.contrib import admin
    from blog.models import Blog
    
    # Blog 模型的管理器
    @admin.register(Blog)
    class BlogAdmin(admin.ModelAdmin):
        list_display=('id', 'caption', 'author', 'publish_time')

### 1.2、admin界面汉化

  默认 admin 后台管理界面是英文的，对英语盲来说用起来不方便。
  可以在 settings.py 中设置: 

    LANGUAGE_CODE = 'zh-CN'
    TIME_ZONE = 'Asia/Shanghai'

  1.8 版本之后的 language code设置不同:

    LANGUAGE_CODE = 'zh-hans'
    TIME_ZONE = 'Asia/Shanghai'

## 二、记录列表界面设置
  记录列表是我们打开后台管理进入到某个应用看到的界面，我们可以对该界面进行设置，主要包括列表和筛选器。

### 2.1、记录列表基本设置

  比较实用的记录列表设置有显示字段、每页记录数和排序等。

    from django.contrib import admin
    from blog.models import Blog

    # Blog模型的管理器
    @admin.register(Blog)
    class BlogAdmin(admin.ModelAdmin):
        #（id字段是Django模型的默认主键）
        list_display = ('id', 'caption')

        ''' 每页显示条目数，默认是100条 '''
        list_per_page = 50

        # ordering 设置默认排序字段，负号表示降序排序
        ordering = ('-publish_time',)

        ''' 设置默认可编辑字段 '''
        list_editable = ['machine_room_id', 'temperature']

        # fk_fields 设置显示外键字段
        fk_fields = ('machine_room_id',)

  另外，默认可以点击每条记录第一个字段的值可以进入编辑界面。
  我们可以设置其他字段也可以点击链接进入编辑界面。

    from django.contrib import admin
    from blog.models import Blog

    # Blog模型的管理器
    @admin.register(Blog)
    class BlogAdmin(admin.ModelAdmin): 
        # 设置哪些字段可以点击进入编辑界面
        list_display_links = ('id', 'caption')

### 2.2、筛选器

  筛选器是Django后台管理重要的功能之一，而且 Django 为我们提供了一些实用的筛选器。主要常用筛选器有下面3个:

    from django.contrib import admin
    from blog.models import Blog

    # Blog模型的管理器
    @admin.register(Blog)
    class BlogAdmin(admin.ModelAdmin):
        list_display = ('id', 'caption',)

        # 筛选器
        ''' 设置过滤选项 '''
        list_filter =('trouble', 'go_time')
        search_fields =('server', 'net', 'mark') # 搜索字段

        ''' 按日期月份筛选 '''
        date_hierarchy = 'go_time'    # 详细时间分层筛选　

  注意:
  使用 date_hierarchy 进行详细时间筛选的时候,可能出现报错: Database returned an invalid datetime value. Are time zone definitions for your database and pytz installed?
  
  处理方法:
  命令行直接执行此命令:
  $ mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
  然后重启数据库即可。

### 2.3、颜色显示
  
  想对某些字段设置颜色，可用下面的设置:

    from django.db import models
    from django.contrib import admin
    from django.utils.html import format_html

    class Person(models.Model):
        first_name = models.CharField(max_length=50)
        last_name = models.CharField(max_length=50)
        color_code = models.CharField(max_length=6)

        def colored_name(self):
            return format_html(
            '<span style="color: #{};">{} {}</span>',
            self.color_code,
            self.first_name,
            self.last_name,
            )

    class PersonAdmin(admin.ModelAdmin):
        list_display = ('first_name', 'last_name', 'colored_name')

### 2.4、调整页面头部显示内容和页面标题
  代码:

    class MyAdminSite(admin.AdminSite):
        # 此处设置页面显示标题
        site_header = '好医生运维资源管理系统'

        # 此处设置页面头部标题
        site_title = '好医生运维'

    admin_site = MyAdminSite(name='management')

    需要注意的是: admin_site = MyAdminSite(name='management') 此处括号内 name 值必须设置，否则将无法使用 admin 设置权限，至于设置什么值，经本人测试，没有影响。

    注册的时候使用 admin_site.register, 而不是默认的admin.site.register。

    也可以通过以下方法设置:

    from django.contrib import admin
    from hys_operation.models import *
    
    admin.site.site_header = '修改后'
    admin.site.site_title = '哈哈'

    不继承 admin.AdminSite 了，直接用 admin.site 下的 site_header 和 site_title 。

### 2.5 通过当前登录的用户过滤显示的数据

    @admin.register(MachineInfo)
    class MachineInfoAdmin(admin.ModelAdmin):

    def get_queryset(self, request):
        """ 函数作用: 使当前登录的用户只能看到自己负责的服务器 """
        qs = super(MachineInfoAdmin, self).get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(user=UserInfo.objects.filter(user_name=request.user))

        list_display = ('machine_ip', 'application')

## 三、编辑界面设置

  编辑界面是我们编辑数据所看到的页面。我们可以对这些字段进行排列设置等。

### 3.1、编辑界面设置

  首先多 ManyToMany 多对多字段设置。可以用 filter_horizontal 或 filter_vertical :

    1、#Many to many 字段
    2、filter_horizontal=('tags',)

  另外，可以用 fields 或 exclude 控制显示或者排除的字段，二选一即可。

  例如，我想只显示标题、作者、分类标签、内容。不想显示是否推荐字段，可以如下两种设置方式:
    
    fields =  ('caption', 'author', 'tags', 'content')
  
  或者
    
    exclude = ('recommend',) #排除该字段
  
  设置之后，你会发现这些字段都是一个字段占一行。若想两个字段放在同一行可以如下设置:
    
    fields =  (('caption', 'author'), 'tags', 'content')

### 5.2、编辑字段集合
  fieldsets 设置可以对字段分块，看起来比较整洁。如下设置:
  
    fieldsets = (
        ("base info", {'fields': ['caption', 'author']}),
        ("Content", {'fields':['content', 'recommend']})
    )

### 5.3、一对多关联
  还有一种比较特殊的情况，父子表的情况。编辑父表之后，再打开子表编辑，而且子表只能一条一条编辑，比较麻烦。这种情况，我们也是可以处理的，将其放在同一个编辑界面中。
  例如，有两个模型，一个是订单主表(BillMain)，记录主要信息；一个是订单明细(BillSub)，记录购买商品的品种和数量等。

  admin.py 如下:

    #coding:utf-8
    from django.contrib import admin
    from bill.models import BillMain, BillSub

    @admin.register(BillMain)
    class BillMainAdmin(admin.ModelAdmin):
        # Inline 把 BillSubInline 关联进来
        inlines = [BillSubInline,] 
        list_display = ('bill_num', 'customer',)

    class BillSubInline(admin.TabularInline):
        model = BillSub
        extra = 5       # 默认显示条目的数量

### 5.4、设置只读字段
  在使用 admin 的时候，ModelAdmi n默认对于 model 的操作只有增加，修改和删除，但是总是有些字段是不希望用户来编辑的。而 readonly_fields 设置之后不管是 admin 还是其他用户都会变成只读，而我们通常只是想限制普通用户。这时我们就可以通过重写 get_readonly_fields 方法来实现对特定用户的只读显示。

    class MachineInfoAdmin(admin.ModelAdmin):
        def get_readonly_fields(self, request, obj=None):
            """ 重新定义此函数，限制普通用户所能修改的字段 """
            if request.user.is_superuser:
                self.readonly_fields = []
                return self.readonly_fields

        readonly_fields = ('machine_ip', 'status')

### 5.5、数据保存时进行一些额外的操作（通过重写ModelAdmin的save_model实现）

    import datetime
    import random

    def save_model(self, request, obj, form, change):
        """ 重新定义此函数，提交时自动添加申请人和备案号 """

        def make_paper_num():
            """ 生成随机备案号 """
            UniqueNum = random.randint(0, 100)
            return UniqueNum

        obj.proposer = request.user
        obj.paper_num = make_paper_num()
        super(DataPaperStoreAdmin, self).save_model(request, obj, form, change)

    其中通过change参数，可以判断是修改还是新增，同时做相应的操作

    同样的，还有 delete_model :
    def delete_model(self, request, obj):
        machine.Device.objects.filter(pk=obj.pk).update(device_status='待报废')
        data = {
                'server_code': obj.machine,
                'user_name': request.user
            }
        common.DeLog.objects.create(**data)  # 创建日志
        super(MachineExDiskAdmin, self).delete_model(request, obj)

### 5.6 修改模版 chang_form.html 让普通用户 无法看到 “历史” 按钮。

### 5.7 对单条数据 显示样式的修改

  change_view方法，允许您在渲染之前轻松自定义响应数据。（凡是对单条数据操作的定制，都可以通过这个方法配合实现）
  详细信息可见: https://docs.djangoproject.com/en/1.10/ref/contrib/admin/#django.contrib.admin.ModelAdmin.change_view

### 5.8 修改 app 的显示名称
  
  Dajngo在Admin后台默认显示的应用的名称为创建 app 时的名称。
  我们如何修改这个 app 的名称达到定制的要求呢，其实 Django 已经在文档里进行了说明。从 Django1.7 以后不再使用 app_label，修改 app 相关需要使用 AppConfig 。我们只需要在应用的 __init__.py 里面进行修改即可:

    from django.apps import AppConfig
    import os

    default_app_config = 'hys_operation.PrimaryBlogConfig'
    VERBOSE_APP_NAME = u"1-本地服务器资源"

    def get_current_app_name(_file):
        return os.path.split(os.path.dirname(_file))[-1]

    class PrimaryBlogConfig(AppConfig):
        name = get_current_app_name(__file__)
        verbose_name = VERBOSE_APP_NAME

### 5.9.自定义列表字段

在DataPaperStore模型中有 end_date 字段，如果当前时间大于end_date 是我们想显示一个“已过期”，但admin列表显示不能直接用该字段，也显示不出来。此时可以通过自定义列表字段显示。如下设置admin:

    import datetime
    from django.utils.html import format_html
    def expired(self, ps):
        """
        自定义列表字段
        根据数据单截止日期和当前日期判断是否过期,并对数据库进行更新"""
        
        end_date = ps.end_date
        if end_date >= datetime.date.today():
            ret = '未过期'
            color_code = 'green'
        else:
            ret = '已过期'
            color_code = 'red'
        DataPaperStore.objects.filter(pk=ps.pk).update(is_expired=ret)
        return format_html('<span style="color: {};">{}</span>', color_code, ret,)
    
    expired.short_description = '是否已过期'

    expired.admin_order_field = 'end_date'  # 使自定义字段 可以通过单击进行排序
