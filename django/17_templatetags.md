## templatetags 的使用

    1、在 app 中创建 templatetags 模块(必须的)
    2、创建任意 .py 文件, 如: my_tag.py

    3、my_tag.py文件:
    from django import template
    from django.utils.safestring import mark_safe
    register = template.Library();     # register 不能改变

    # 过滤器只能传两个参数，可以写在控制语句中
    @register.filter
    def filter_multi(x,y):
        return x * y;

    # 自定义的标签可以传多个参数，不能写在控制语句中
    @register.simple_tag
    def simple_tag(x, y):
        return x * y

    4、在使用自定义 simple_tag 和 filter 的 html 文件中导入之前创建的 my_tag.py:
    {% load my_tag %}

    5、使用 simple_tag 和 filter:
    {# 调用自定义的过滤器 #}
    {{ d.age|filter_multi:3 }}<br>
    {{ l|filter_multi:3 }}<br>

    {# 调用自定义的标签 #}
    {% simple_tag l.0 l.1 %}

