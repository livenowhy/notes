## 模型(Models)
  
  模型是你的数据的唯一的、确定的信息源。
  它包含你所储存数据的必要字段和行为。
  通常，每个模型对应数据库中唯一的一张表。
  基础:
  1、每个模型都是一个Python类，它们都是 django.db.models.Model 的子类。
  2、每一个模型属性都代表数据库中的一个字段。

### 字段选项

  null  如果为True, Django将在数据库中把空值存储为NULL。 默认为False。
  blank 如果为True, 该字段允许为空值, 默认为False。
  要注意, 这与 null 不同。 null 纯粹是数据库范畴,指数据库中字段内容是否允许为空, 而 blank 是表单数据输入验证范畴的。 如果一个字段的blank=True，表单的验证将允许输入一个空值。 如果字段的blank=False，该字段就是必填的。
  
  choices 由二项元组构成的一个可迭代对象(例如，列表或元组)，用来给字段提供选择项。
  如果设置了 choices ，默认的表单将是一个选择框而不是标准的文本框，而且这个选择框的选项就是 choices 中的选项。每个元组中的第一个元素是将被存储在数据库中的值。 第二个元素将由默认窗体小部件或 ModelChoiceField 显示。给定一个模型实例，可以使用get_FOO_display()方法来访问选项字段的显示值。 例如：

    from django.db import models
    class Person(models.Model):
        SHIRT_SIZES = (
            ('S', 'Small'),
            ('M', 'Medium'),
            ('L', 'Large'),
        )
        name = models.CharField(max_length=60)
        shirt_size = models.CharField(max_length=1, choices=SHIRT_SIZES)
    >>> p = Person(name="Fred Flintstone", shirt_size="L")
    >>> p.save()
    >>> p.shirt_size
    'L'
    >>> p.get_shirt_size_display()
    'Large'

    default: 字段的默认值。可以是一个值或者可调用对象。如果可调用, 每个新对象创建时它都会被调。
    
    help_text: 表单部件额外显示的帮助内容。 即使字段不在表单中使用，它对生成文档也很有用。
    
    primary_key: 如果为True，那么这个字段就是模型的主键。

    主键字段是只读的。如果你在一个已存在的对象上面更改主键的值并且保存，一个新的对象将会在原有对象之外创建出来。 例如:

    from django.db import models
    
    class Fruit(models.Model):
        name = models.CharField(max_length=100, primary_key=True)
    >>> fruit = Fruit.objects.create(name='Apple')
    >>> fruit.name = 'Pear'
    >>> fruit.save()
    >>> Fruit.objects.values_list('name', flat=True)
    <QuerySet ['Apple', 'Pear']>

    unique: 如果为True, 则这个字段在整张表中必须是唯一的。

### 自动主键字段

  默认情况下，Django 会给每个模型添加下面这个字段:
  id = models.AutoField(primary_key=True) 这是一个自增主键字段。
  如果你想指定一个自定义主键字段，只要在某个字段上指定 primary_key=True 即可。 如果 Django 看到你显式地设置了 Field.primary_key，就不会自动添加 id 列。
  每个模型只能有一个字段指定primary_key=True（无论是显式声明还是自动添加）。

### 字段的自述名

  除 ForeignKey、ManyToManyField 和 OneToOneField 之外，每个字段类型都接受一个可选的位置参数(在第一的位置)— 字段的自述名。 如果没有给定自述名，Django 将根据字段的属性名称自动创建自述名 —— 将属性名称的下划线替换成空格。
  在这个例子中，自述名是 "person's first name":
  first_name = models.CharField("person's first name", max_length=30)

  在这个例子中，自述名是 "first name":
  first_name = models.CharField(max_length=30)

  ForeignKey、ManyToManyField 和 OneToOneField 都要求第一个参数是一个模型类，所以要使用 verbose_name 关键字参数才能指定自述名:
  poll = models.ForeignKey(Poll, on_delete=models.CASCADE, verbose_name="the related poll")
  习惯上，verbose_name 的首字母不用大写。 Django 在必要的时候会自动大写首字母。


### 模型属性 objects

  模型最重要的属性是 Manager。它是Django 模型进行数据库查询操作的接口，并用于从数据库提取实例。 如果没有自定义Manager，则默认的名称为objects。 Managers 只能通过模型类访问，而不能通过模型实例访问。

### 模型方法

    可以在模型上定义自定义的方法来给你的对象添加自定义的“底层”功能。 Manager 方法用于“表范围”的事务，模型的方法应该着眼于特定的模型实例。
    这是一个非常有价值的技术，让业务逻辑位于同一个地方 — 模型中。
    例如，下面的模型具有一些自定义的方法:

    from django.db import models
    class Person(models.Model):
        first_name = models.CharField(max_length=50)
        last_name = models.CharField(max_length=50)
        birth_date = models.DateField()
    
        def baby_boomer_status(self):
            "Returns the person's baby-boomer status."
            import datetime
            if self.birth_date < datetime.date(1945, 8, 1):
                return "Pre-boomer"
            elif self.birth_date < datetime.date(1965, 1, 1):
                return "Baby boomer"
            else:
                return "Post-boomer"
    
        @property
        def full_name(self):
            "Returns the person's full name."
            return '%s %s' % (self.first_name, self.last_name)

### 抽象基类
    
    当你想将一些共有信息放进其它一些 model 的时候，抽象化类是十分有用的。你编写完基类之后，在 Meta类中设置 abstract=True, 这个模型就不会被用来创建任何数据表。取而代之的是，当它被用来作为一个其他 model 的基类时，它的字段将被加入那些子类中。 如果抽象基类和它的子类有相同的字段名，那么将会出现 error（并且Django将抛出一个exception）。
    一个例子

    from django.db import models
    class CommonInfo(models.Model):
        name = models.CharField(max_length=100)
        age = models.PositiveIntegerField()
    
        class Meta:
            abstract = True


    Meta继承: 当一个抽象基类被创建的时候, Django把你在基类内部定义的 Meta 类作为一个属性使其可用。 如果子类没有声明自己的 Meta 类, 它将会继承父类的 Meta。 如果子类想要扩展父类的 Meta 类，它可以子类化它。